$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    Write-Host "==> Removing citation tags from all files (excluding script files) using regex..." -ForegroundColor Cyan
    $currentScriptPath = $MyInvocation.MyCommand.Path
    Get-ChildItem -Path "." -Recurse -File | Where-Object { 
        $_.FullName -notmatch '\\\.git\\|\\.dart_tool\\|build\\' -and $_.FullName -ne $currentScriptPath -and $_.Name -ne 'check.ps1' -and $_.Name -ne 'check.sh'
    } | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -match '\[cite:\s*[^\]]+\]') {
            $newContent = [System.Text.RegularExpressions.Regex]::Replace($content, '\[cite:\s*[^\]]+\]', '')
            Set-Content -Path $_.FullName -Value $newContent -NoNewline
            Write-Host "Removed citations from: $($_.FullName)" -ForegroundColor Yellow
        }
    }

    Write-Host "==> Fetching dependencies..." -ForegroundColor Cyan
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed with exit code $LASTEXITCODE" }

    Write-Host "==> Running static analysis..." -ForegroundColor Cyan
    flutter analyze --fatal-infos --fatal-warnings
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed with exit code $LASTEXITCODE" }

    Write-Host "==> Checking code formatting..." -ForegroundColor Cyan
    dart format --output=none --set-exit-if-changed .
    if ($LASTEXITCODE -ne 0) { throw "dart format check failed with exit code $LASTEXITCODE" }

    # Ensure Navigator.of is not used and GoRouter is used for navigation across all files in the root directory
    Write-Host "==> Verifying navigation architecture (GoRouter enforcement)..." -ForegroundColor Cyan
    $navigatorUsage = Get-ChildItem -Path "." -Recurse | Where-Object { -not $_.PSIsContainer } | Select-String -Pattern "Navigator\.of"
    if ($navigatorUsage) {
        throw "Forbidden 'Navigator.of' usage detected. Use GoRouter instead."
    }

    # Keep the performance benchmark isolated from concurrent test workloads.
    Write-Host "==> Running test suite..." -ForegroundColor Cyan
    flutter test --concurrency=1
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}