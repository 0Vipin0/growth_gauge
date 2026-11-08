$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    flutter analyze --fatal-infos --fatal-warnings
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed with exit code $LASTEXITCODE" }

    dart format --output=none --set-exit-if-changed .
    if ($LASTEXITCODE -ne 0) { throw "dart format check failed with exit code $LASTEXITCODE" }

    # Ensure Navigator.of is not used and GoRouter is used for navigation across source files
    $navigatorUsage = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart" | Select-String -Pattern "Navigator\.of"
    if ($navigatorUsage) {
        throw "Forbidden 'Navigator.of' usage detected in 'lib/'. Use GoRouter instead."
    }

    # Keep the performance benchmark isolated from concurrent test workloads.
    flutter test --concurrency=1
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
