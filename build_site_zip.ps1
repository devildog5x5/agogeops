# Build AgogeOps-<version>.zip for Hostinger public_html.
# Zip entries use forward slashes. Keep the page list in sync with sitemap.xml and SOP.md.
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
$ZipName = "AgogeOps-$Version.zip"
$Zip = Join-Path $Out $ZipName

$Pages = @(
    "index.html",
    "it-operations.html",
    "security-operations.html",
    "iso-readiness.html",
    "infrastructure.html"
)
$RootFiles = @(
    "LICENSE",
    "robots.txt",
    "sitemap.xml",
    "site.webmanifest",
    ".htaccess"
)

New-Item -ItemType Directory -Force -Path $Out | Out-Null
Get-ChildItem -Path $Out -Filter "AgogeOps-*.zip" -ErrorAction SilentlyContinue | Remove-Item -Force

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

function Add-SiteFile {
    param(
        [System.IO.Compression.ZipArchive]$Archive,
        [string]$Source,
        [string]$EntryName
    )
    $EntryName = ($EntryName -replace '\\', '/').TrimStart('/')
    if ($EntryName -match '\\') {
        throw "Zip entry must use forward slashes: $EntryName"
    }
    $entry = $Archive.CreateEntry($EntryName, [System.IO.Compression.CompressionLevel]::Optimal)
    $inStream = [System.IO.File]::OpenRead($Source)
    try {
        $outStream = $entry.Open()
        try { $inStream.CopyTo($outStream) } finally { $outStream.Dispose() }
    } finally {
        $inStream.Dispose()
    }
}

$archive = [System.IO.Compression.ZipFile]::Open($Zip, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($name in ($Pages + $RootFiles)) {
        $path = Join-Path $Root $name
        if (-not (Test-Path $path)) { throw "Missing site file: $name" }
        Add-SiteFile $archive $path $name
    }

    $keyFiles = @(Get-ChildItem -Path $Root -File | Where-Object { $_.Name -match '^[0-9a-f]{32}\.txt$' })
    if ($keyFiles.Count -lt 1) { throw "IndexNow key file is missing from the repo root" }
    foreach ($file in $keyFiles) {
        Add-SiteFile $archive $file.FullName $file.Name
    }

    Get-ChildItem -Path $Root -File -Filter "google*.html" | ForEach-Object {
        Add-SiteFile $archive $_.FullName $_.Name
    }
    $bing = Join-Path $Root "BingSiteAuth.xml"
    if (Test-Path $bing) {
        Add-SiteFile $archive $bing "BingSiteAuth.xml"
    }

    $assets = Join-Path $Root "assets"
    Get-ChildItem -Path $assets -Recurse -File | ForEach-Object {
        $rel = $_.FullName.Substring($assets.Length).TrimStart('\', '/')
        Add-SiteFile $archive $_.FullName ("assets/" + $rel)
    }
} finally {
    $archive.Dispose()
}

$check = [System.IO.Compression.ZipFile]::OpenRead($Zip)
try {
    if ($check.Entries.Count -lt 1) { throw "Zip is empty" }
    $allowed = '^(index|it-operations|security-operations|iso-readiness|infrastructure)\.html$|^(LICENSE|robots\.txt|sitemap\.xml|site\.webmanifest|\.htaccess|BingSiteAuth\.xml)$|^[0-9a-f]{32}\.txt$|^google[A-Za-z0-9]+\.html$|^assets/.+'
    $forbidden = '(?i)(^|/)(\.git|installers|build)(/|$)|(?i)\.(zip|7z|rar|tar|gz|tgz|bz2|xz|ps1|psm1|psd1|sh|bash|bat|cmd|py|md)$'
    foreach ($entry in $check.Entries) {
        $name = $entry.FullName
        if ($name -match '\\') { throw "Zip entry uses a backslash: $name" }
        if ($name -notmatch $allowed) { throw "Zip entry is not a public site file: $name" }
        if ($name -match $forbidden) { throw "Zip entry must not be source or an archive: $name" }
    }
} finally {
    $check.Dispose()
}

Write-Host "Built v$Version"
Write-Host "  $Zip"
Write-Host ("Size {0:N1} KB" -f ((Get-Item $Zip).Length / 1KB))
Write-Host "Hostinger: unzip into public_html (files at zip root, not a nested folder)"
