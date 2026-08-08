# ---------------------------------------------------------------------------------------------------------------------
# Prepares the mod for the manual upload to Steam. See docs/workshop-upload.md for more info
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
$Target = Join-Path $env:USERPROFILE "Zomboid\Workshop\[MyMod]"
$TargetContents = "$Target\Contents\mods\[MyMod]"

New-Item -ItemType Directory -Force -Path "$TargetContents" | Out-Null

Copy-Item `
    "$Root\workshop\workshop.txt" `
    "$Target\workshop.txt"
Copy-Item `
    "$Root\workshop\preview.png" `
    "$Target\preview.png"
    
robocopy `
    $Source `
    $TargetContents `
    /MIR /NFL /NDL /NJH /NJS

if ($LASTEXITCODE -ge 8) {
    throw "Could not stage Workshop content. Robocopy exit code: $LASTEXITCODE"
}

Write-Host "Mod(s) prepared for upload at $Target"
Write-Host "Open Project Zomboid -> Workshop -> Create and update items to upload it."
