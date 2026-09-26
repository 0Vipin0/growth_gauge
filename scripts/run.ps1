param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $FlutterArgs
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    flutter run @FlutterArgs
    if ($LASTEXITCODE -ne 0) { throw "flutter run failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
