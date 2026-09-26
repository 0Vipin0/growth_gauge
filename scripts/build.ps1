param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('apk', 'appbundle', 'web', 'windows', 'linux', 'macos')]
    [string] $Target,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $FlutterArgs
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    flutter build $Target @FlutterArgs
    if ($LASTEXITCODE -ne 0) { throw "flutter build $Target failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
