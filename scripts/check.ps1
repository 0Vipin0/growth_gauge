$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    Write-Host "==> Fetching dependencies..." -ForegroundColor Cyan
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed with exit code $LASTEXITCODE" }

    Write-Host "==> Running static analysis..." -ForegroundColor Cyan
    flutter analyze --fatal-infos --fatal-warnings
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed with exit code $LASTEXITCODE" }

    Write-Host "==> Checking code formatting..." -ForegroundColor Cyan
    dart format --output=none --set-exit-if-changed .
    if ($LASTEXITCODE -ne 0) { throw "dart format check failed with exit code $LASTEXITCODE" }

    # Ensure Navigator.of is not used and GoRouter is used for navigation across source files
    Write-Host "==> Verifying navigation architecture (GoRouter enforcement)..." -ForegroundColor Cyan
    $navigatorUsage = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart" | Select-String -Pattern "Navigator\.of"
    if ($navigatorUsage) {
        throw "Forbidden 'Navigator.of' usage detected in 'lib/'. Use GoRouter instead."
    }

    # Keep the performance benchmark isolated from concurrent test workloads.
    Write-Host "==> Running test suite..." -ForegroundColor Cyan
    flutter test --concurrency=1
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
