$ErrorActionPreference = "Stop"

$Root = Split-Path $PSScriptRoot -Parent
$Source = Join-Path $Root "source\[MyMod]"
$Target = Join-Path $env:USERPROFILE "Zomboid\Workshop\[MyMod]"

& "$PSScriptRoot\generate-metadata.ps1"
if ($LASTEXITCODE -gt 0) {
    throw "Could not generate metadata."
}

if (-not (Test-Path $Source)) {
    throw "Mod source not found: $Source"
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

robocopy `
    $Source `
    $Target `
    /MIR /NFL /NDL /NJH /NJS

if ($LASTEXITCODE -ge 8) {
    throw "Could not stage Workshop content. Robocopy exit code: $LASTEXITCODE"
}

Write-Host "Workshop content staged at $Target"
Write-Host "Open Project Zomboid -> Workshop -> Create and update items to upload it."
