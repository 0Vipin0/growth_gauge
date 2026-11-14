<#
.SYNOPSIS
    Windows wrapper for validateTemplates.dart.

.DESCRIPTION
    Thin launcher only. All validation logic and all output formatting live in
    validateTemplates.dart, so results are identical on Windows, Linux and macOS.

    Dart lookup order: $env:DART, `dart` on PATH, $env:FLUTTER_ROOT, the SDK
    bundled with the `flutter` found on PATH.
    Override the script location with $env:VALIDATE_TEMPLATES_DART.

.EXAMPLE
    .\validateTemplates.ps1
    .\validateTemplates.ps1 .\exercise_seed_data.dart .\workout_template_seed_data.dart --strict --show-all

    The previous PowerShell-style switches are still accepted and translated:
    -Strict, -ShowAll, -NoColor, -ExerciseFile <path>, -TemplateFile <path>.

.NOTES
    Exit codes: 0 = passed, 1 = validation failed, 2 = usage / input error.
#>
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$dartScript = $env:VALIDATE_TEMPLATES_DART
if (-not $dartScript) { $dartScript = Join-Path $scriptDir 'validateTemplates.dart' }

function Find-Dart {
    if ($env:DART -and (Test-Path -LiteralPath $env:DART)) { return $env:DART }

    $cmd = Get-Command dart -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $roots = New-Object System.Collections.Generic.List[string]
    if ($env:FLUTTER_ROOT) { $roots.Add($env:FLUTTER_ROOT) }
    $flutter = Get-Command flutter -ErrorAction SilentlyContinue
    if ($flutter) { $roots.Add((Split-Path -Parent (Split-Path -Parent $flutter.Source))) }

    foreach ($root in $roots) {
        foreach ($name in @('dart.exe', 'dart')) {
            $candidate = Join-Path $root (Join-Path 'bin\cache\dart-sdk\bin' $name)
            if (Test-Path -LiteralPath $candidate) { return $candidate }
        }
    }
    return $null
}

if (-not (Test-Path -LiteralPath $dartScript -PathType Leaf)) {
    [Console]::Error.WriteLine("[ERROR] Cannot find validateTemplates.dart at: $dartScript")
    [Console]::Error.WriteLine('        Keep it next to this wrapper or set VALIDATE_TEMPLATES_DART.')
    exit 2
}

$dart = Find-Dart
if (-not $dart) {
    [Console]::Error.WriteLine('[ERROR] Dart SDK not found.')
    [Console]::Error.WriteLine('        Install Dart (https://dart.dev/get-dart) or Flutter, or set the DART environment variable.')
    exit 2
}

# Translate the earlier PowerShell-style switches into the Dart CLI options.
$passthru = New-Object System.Collections.Generic.List[string]
for ($i = 0; $i -lt $args.Count; $i++) {
    $a = [string]$args[$i]
    if ($a -ieq '-Strict') { $passthru.Add('--strict') }
    elseif ($a -ieq '-ShowAll') { $passthru.Add('--show-all') }
    elseif ($a -ieq '-NoColor') { $passthru.Add('--no-color') }
    elseif (($a -ieq '-ExerciseFile') -and (($i + 1) -lt $args.Count)) {
        $passthru.Add('--exercise-file')
        $i++
        $passthru.Add([string]$args[$i])
    }
    elseif (($a -ieq '-TemplateFile') -and (($i + 1) -lt $args.Count)) {
        $passthru.Add('--template-file')
        $i++
        $passthru.Add([string]$args[$i])
    }
    else { $passthru.Add($a) }
}

$passArray = $passthru.ToArray()
& $dart $dartScript @passArray
exit $LASTEXITCODE
