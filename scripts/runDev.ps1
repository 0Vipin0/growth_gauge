<#
.SYNOPSIS
    Runs the Growth Gauge application in development mode using lib/main_dev.dart.
.NOTES
    TROUBLESHOOTING (Execution Policy Error):
    If you encounter a security error running scripts, run:
    Set-ExecutionPolicy Bypass -Scope Process
.EXAMPLE
    .\scripts\runDev.ps1 -ClearStorage -BypassAuth -Onboarding
#>

param(
    [switch] $ClearStorage,
    [switch] $BypassAuth,
    [switch] $Onboarding,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $FlutterArgs
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot

try {
    if ($ClearStorage) {
        Write-Host "==> Clearing local storage and Drift DB at %APPDATA%\GrowthGauge\Growth Gauge..." -ForegroundColor Cyan
        $appDataPath = "$env:APPDATA\GrowthGauge\Growth Gauge"
        if (Test-Path $appDataPath) {
            Remove-Item -Recurse -Force $appDataPath
            Write-Host "==> Successfully cleared local storage." -ForegroundColor Green
        } else {
            Write-Host "==> No existing local storage found at target path." -ForegroundColor Yellow
        }
    }

    Write-Host "==> Fetching dependencies..." -ForegroundColor Cyan
    flutter pub get

    $argsList = @("-t", "lib/main_dev.dart")
    if ($BypassAuth) {
        $argsList += "--dart-define=DEV_BYPASS_AUTH=true"
    }
    if ($Onboarding) {
        $argsList += "--dart-define=DEV_FORCE_ONBOARDING=true"
    }

    Write-Host "==> Launching app in development mode with main_dev.dart..." -ForegroundColor Cyan
    flutter run @argsList @FlutterArgs
}
finally {
    Pop-Location
}