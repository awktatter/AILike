#!/usr/bin/env bash
# Gather structural signal about a project using native OS/shell tools so an
# agent can build context without LLM-driven file exploration.
# Prefers the best tool available and degrades gracefully:
#   listing: git ls-files -> fd -> find
#   search:  rg -> grep
#   layout:  tree -> listing
# Usage: scripts/survey.sh [dir]
set -eu
root="${1:-.}"
cd "$root"

is_git() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
have()   { command -v "$1" >/dev/null 2>&1; }

# All tracked/relevant files, one per line, excluding noise.
list_files() {
  if is_git; then
    git ls-files
  elif have fd; then
    fd --type f --hidden --exclude .git --exclude node_modules --exclude .venv
  else
    find . -type f \
      -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/.venv/*' \
      -not -path '*/dist/*' -not -path '*/build/*' | sed 's|^\./||'
  fi
}

# Search tracked files for a pattern; prints "file:match".
search() { # $1 = regex
  if have rg; then
    rg --no-heading --line-number --max-count 1 "$1" $(list_files) 2>/dev/null
  else
    # shellcheck disable=SC2046
    grep -nE "$1" $(list_files) 2>/dev/null
  fi
}

echo "## Root"
pwd
echo

echo "## Tools used"
{ is_git && echo "- listing: git ls-files"; } \
  || { have fd && echo "- listing: fd"; } || echo "- listing: find"
have rg && echo "- search: rg" || echo "- search: grep"
have tree && echo "- layout: tree"
echo

echo "## Top-level layout (depth 2)"
if have tree; then
  tree -L 2 -a -I '.git|node_modules|.venv|dist|build' --noreport
else
  list_files | awk -F/ '{ if (NF>1) print $1"/"$2; else print $1 }' | sort -u | head -n 200
fi
echo

echo "## Manifests & config"
for f in package.json pyproject.toml requirements.txt setup.py go.mod Cargo.toml \
         pom.xml build.gradle Gemfile composer.json Makefile Dockerfile \
         docker-compose.yml README.md README.rst; do
  [ -e "$f" ] && echo "- $f"
done
echo

echo "## CI / tooling"
ls -1 .github/workflows 2>/dev/null | sed 's|^|- .github/workflows/|'
for f in .pre-commit-config.yaml .editorconfig tsconfig.json ruff.toml .ruff.toml \
         pytest.ini tox.ini .eslintrc .eslintrc.js .eslintrc.json; do
  [ -e "$f" ] && echo "- $f"
done
echo

echo "## Language mix (top extensions by file count)"
list_files | sed -n 's|.*\.\([A-Za-z0-9]\{1,8\}\)$|\1|p' \
  | sort | uniq -c | sort -rn | head -n 12
echo

echo "## Entry-point candidates"
search '^\s*(def|async def) main\b|if __name__\s*==|^\s*func main\(|^\s*(public|int)\s+static?\s*.*\bmain\s*\(|"(main|bin)"\s*:' \
  | head -n 20 || true
echo

echo "## Likely test locations"
if have fd; then
  fd --type d '^(tests?|__tests__|spec)$' --exclude node_modules | head -n 20
else
  find . -maxdepth 3 -type d \( -name test -o -name tests -o -name __tests__ -o -name spec \) \
    -not -path '*/node_modules/*' 2>/dev/null | sed 's|^\./||' | head -n 20
fi
