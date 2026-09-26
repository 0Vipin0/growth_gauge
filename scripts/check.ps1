$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    flutter analyze --fatal-infos --fatal-warnings
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed with exit code $LASTEXITCODE" }

    dart format --output=none --set-exit-if-changed .
    if ($LASTEXITCODE -ne 0) { throw "dart format check failed with exit code $LASTEXITCODE" }

    flutter test
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
