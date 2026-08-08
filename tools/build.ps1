# ---------------------------------------------------------------------------------------------------------------------
# Runs tests, generates metadata and installs the mod locally.
# ---------------------------------------------------------------------------------------------------------------------

$ErrorActionPreference = "Stop"

& "$PSScriptRoot\test.ps1"

if ($LASTEXITCODE -gt 0) {
    Write-Host "Mod(s) are faulty and will not be copied into PZ!"
    exit $LASTEXITCODE
}


& "$PSScriptRoot\generate-metadata.ps1"

if ($LASTEXITCODE -gt 0) {
    Write-Host "Could not generate metadata (mod.info, workshop.txt and / or README.md)"
    exit $LASTEXITCODE
}

$Root = Split-Path $PSScriptRoot -Parent
$Source = Join-Path $Root "source\[MyMod]"
$Target = Join-Path $env:USERPROFILE "Zomboid\mods\[MyMod]"

robocopy `
    $Source `
    $Target `
    /MIR /NFL /NDL /NJH /NJS

if ($LASTEXITCODE -ge 8) {
    throw "Could not copy mod. Robocopy exit code: $LASTEXITCODE"
}

Write-Host "Mod(s) installed at $Target"