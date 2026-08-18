#!/usr/bin/env pwsh
# PowerShell port of survey.sh — gather structural signal about a project using
# native tools so an agent can build context without LLM-driven exploration.
# Prefers the best tool available and degrades gracefully:
#   listing: git ls-files -> fd -> Get-ChildItem
#   search:  rg -> Select-String
# Usage: scripts/survey.ps1 [dir]
param([string]$Root = ".")

$ErrorActionPreference = "SilentlyContinue"
Set-Location $Root

function Have($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }
function IsGit {
  if (-not (Have git)) { return $false }
  git rev-parse --is-inside-work-tree 2>$null | Out-Null
  return $LASTEXITCODE -eq 0
}

$excludeDirs = @('.git', 'node_modules', '.venv', 'dist', 'build')

function List-Files {
  if (IsGit) {
    git ls-files
  } elseif (Have fd) {
    fd --type f --hidden --exclude .git --exclude node_modules --exclude .venv
  } else {
    Get-ChildItem -Recurse -File -Force | Where-Object {
      $p = $_.FullName
      -not ($excludeDirs | Where-Object { $p -match "[\\/]$_[\\/]" })
    } | ForEach-Object { (Resolve-Path -Relative $_.FullName) -replace '^\.[\\/]', '' }
  }
}

"## Root"
(Get-Location).Path
""

"## Tools used"
if (IsGit) { "- listing: git ls-files" }
elseif (Have fd) { "- listing: fd" }
else { "- listing: Get-ChildItem" }
if (Have rg) { "- search: rg" } else { "- search: Select-String" }
""

"## Top-level layout (depth 2)"
List-Files |
  ForEach-Object { ($_ -replace '\\', '/') -replace '^\./', '' } |
  ForEach-Object {
    $parts = $_.Split('/')
    if ($parts.Count -gt 1) { "$($parts[0])/$($parts[1])" } else { $parts[0] }
  } | Sort-Object -Unique | Select-Object -First 200
""

"## Manifests & config"
foreach ($f in 'package.json', 'pyproject.toml', 'requirements.txt', 'setup.py',
  'go.mod', 'Cargo.toml', 'pom.xml', 'build.gradle', 'Gemfile', 'composer.json',
  'Makefile', 'Dockerfile', 'docker-compose.yml', 'README.md', 'README.rst') {
  if (Test-Path $f) { "- $f" }
}
""

"## CI / tooling"
if (Test-Path .github/workflows) {
  Get-ChildItem .github/workflows -File | ForEach-Object { "- .github/workflows/$($_.Name)" }
}
foreach ($f in '.pre-commit-config.yaml', '.editorconfig', 'tsconfig.json',
  'ruff.toml', '.ruff.toml', 'pytest.ini', 'tox.ini',
  '.eslintrc', '.eslintrc.js', '.eslintrc.json') {
  if (Test-Path $f) { "- $f" }
}
""

"## Language mix (top extensions by file count)"
List-Files |
  ForEach-Object { [System.IO.Path]::GetExtension($_) } |
  Where-Object { $_ } | ForEach-Object { $_.TrimStart('.') } |
  Group-Object | Sort-Object Count -Descending | Select-Object -First 12 |
  ForEach-Object { "{0,4} {1}" -f $_.Count, $_.Name }
""

"## Entry-point candidates"
$pattern = '^\s*(def|async def) main\b|if __name__\s*==|^\s*func main\(|\bstatic\b.*\bmain\s*\(|"(main|bin)"\s*:'
$files = @(List-Files)
if ($files.Count -gt 0) {
  if (Have rg) {
    rg --no-heading --line-number --max-count 1 $pattern @files 2>$null | Select-Object -First 20
  } else {
    Select-String -Path $files -Pattern $pattern -List 2>$null |
      ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line.Trim())" } |
      Select-Object -First 20
  }
}
""

"## Likely test locations"
Get-ChildItem -Recurse -Directory -Depth 2 -Force |
  Where-Object {
    $_.Name -match '^(tests?|__tests__|spec)$' -and $_.FullName -notmatch '[\\/]node_modules[\\/]'
  } | ForEach-Object { (Resolve-Path -Relative $_.FullName) -replace '^\.[\\/]', '' } |
  Select-Object -First 20
