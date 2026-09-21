# Build AgogeOps-<version>.zip for Hostinger public_html
$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot
$VersionFile = Join-Path $Root "VERSION"
if (-not (Test-Path $VersionFile)) {
    throw "VERSION file is missing"
}
$Version = (Get-Content -Path $VersionFile -Raw).Trim()
if ($Version -notmatch '^\d+\.\d+\.\d+$') {
    throw "VERSION must be x.y.z (got '$Version')"
}

$Out = Join-Path $Root "installers"
$Stage = Join-Path $Root "build\sitedrop"
$ZipName = "AgogeOps-$Version.zip"
$Zip = Join-Path $Out $ZipName

New-Item -ItemType Directory -Force -Path $Out | Out-Null
if (Test-Path $Stage) { Remove-Item -Recurse -Force $Stage }
New-Item -ItemType Directory -Force -Path $Stage | Out-Null

Copy-Item -Path (Join-Path $Root "index.html") -Destination $Stage
Copy-Item -Path (Join-Path $Root "LICENSE") -Destination $Stage
Copy-Item -Path (Join-Path $Root "assets") -Destination (Join-Path $Stage "assets") -Recurse

Get-ChildItem -Path $Out -Filter "AgogeOps-*.zip" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path $Stage -Force | Compress-Archive -DestinationPath $Zip -Force

Write-Host "Built v$Version"
Write-Host "  $Zip"
Write-Host ("Size {0:N1} KB" -f ((Get-Item $Zip).Length / 1KB))
Write-Host "Hostinger: unzip into public_html (files at zip root, not a nested folder)"
