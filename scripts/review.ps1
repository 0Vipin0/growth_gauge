<#
.SYNOPSIS
    Read-only Growth Gauge codebase review and validation snapshot.
.DESCRIPTION
    Prints evidence signals for roadmap phases, source/test inventories, and
    bounded diagnostic checks. It does not run check.ps1, pub get, generators,
    format-in-place, builds, or data-clearing commands. Redirect output to save
    and share the report, for example: .\scripts\review.ps1 *> review-output.txt
#>
param([ValidateRange(10, 900)][int] $TimeoutSeconds = 120)
$ErrorActionPreference = 'Continue'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
    $started = Get-Date
    Write-Output "Growth Gauge read-only review | $(Get-Date -Format o) | root=$projectRoot"
    Write-Output 'Policy: no source/test/config writes; pub get and code generation are intentionally omitted.'
    Write-Output 'Working tree:'; git status --short
    $phases = @(
        @{N='01 Foundation / Drift'; S='lib/core/database'; T='test/core/database'},
        @{N='02 Catalog / templates'; S='lib/features/catalog'; T='test/features/catalog'},
        @{N='03 Session runtime'; S='lib/features/session'; T='test/features/session'},
        @{N='04 Analytics'; S='lib/features/analytics'; T='test/features/analytics'},
        @{N='05 User / onboarding'; S='lib/features/user'; T='test/features/user'},
        @{N='06 Portability'; S='lib/features/portability'; T='test/features/portability'},
        @{N='07 Hardening / UI polish'; S='lib/features/home'; T='test/features/home'},
        @{N='08 Structure consistency'; S='lib/features'; T='test'},
        @{N='09 Test coverage'; S='test'; T='test'},
        @{N='10 GoRouter'; S='lib/core/routing'; T='test/core/app'},
        @{N='11 Bloc state'; S='lib/features'; T='test/features'},
        @{N='12 Responsive / A11y'; S='lib/features/common/presentation'; T='test/features/common'},
        @{N='13 Catalog steps'; S='lib/features/catalog'; T='test/features/catalog'},
        @{N='14 Secure local auth'; S='lib/features/authentication'; T='test/features/authentication'},
        @{N='15 Sounds / reminders / TTS'; S='lib/features/notification'; T='test/features/notification'},
        @{N='16 CI / build automation'; S='.github/workflows'; T='test'},
        @{N='17 Modular design system'; S='lib/features/common/presentation/widgets'; T='test/core/theme'},
        @{N='18 Biometric intelligence'; S='lib/features/user'; T='test/features/user'}
    )
    Write-Output "`nPHASE EVIDENCE (presence is a signal, not a completion verdict)"
    for ($i = 0; $i -lt $phases.Count; $i++) {
        $phase = $phases[$i]
        $sourceCount = @(Get-ChildItem -LiteralPath $phase.S -Recurse -File -ErrorAction SilentlyContinue).Count
        $testCount = @(Get-ChildItem -LiteralPath $phase.T -Recurse -File -Filter '*test.dart' -ErrorAction SilentlyContinue).Count
        $number = $i + 1
        $planRow = Select-String -LiteralPath 'docs/implementation-plan.md' -Pattern "^\| \*\*Phase $number\*\*" | Select-Object -First 1
        $planStatus = 'phase row not found'
        if ($planRow -and $planRow.Line -match '`(\[x\] COMPLETED|\[~\] IN PROGRESS|\[ \] PLANNED)`') { $planStatus = $Matches[1] }
        Write-Output ("{0,-32} sourceFiles={1,-4} testFiles={2,-3} plan={3}" -f $phase.N,$sourceCount,$testCount,$planStatus)
    }
    Write-Output "`nFULL SOURCE / TEST FILE INVENTORY"
    Write-Output '--- lib files ---'; Get-ChildItem lib -Recurse -File | ForEach-Object { $_.FullName.Substring($projectRoot.Length + 1) }
    Write-Output '--- test files ---'; Get-ChildItem test -Recurse -File | ForEach-Object { $_.FullName.Substring($projectRoot.Length + 1) }
    function Invoke-Bounded([string] $Label, [string] $Executable, [string[]] $Arguments) {
        Write-Output "`n=== $Label ==="
        $tempBase = Join-Path $env:TEMP ("growth-gauge-review-{0}" -f [guid]::NewGuid().ToString('N'))
        $stdoutPath = "$tempBase.out"; $stderrPath = "$tempBase.err"
        try {
            $process = Start-Process -FilePath $Executable -ArgumentList $Arguments -WorkingDirectory $projectRoot -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
            if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
                if (Test-Path $stdoutPath) { Get-Content $stdoutPath }; if (Test-Path $stderrPath) { Get-Content $stderrPath }
                & taskkill.exe /PID $process.Id /T /F 2>$null | Out-Null
                Write-Output "RESULT=TIMEOUT after ${TimeoutSeconds}s; process tree terminated."
            }
            else { $process.Refresh(); if (Test-Path $stdoutPath) { Get-Content $stdoutPath }; if (Test-Path $stderrPath) { Get-Content $stderrPath }; if ($null -eq $process.ExitCode) { Write-Output 'EXIT_CODE=unavailable from launcher' } else { Write-Output "EXIT_CODE=$($process.ExitCode)" } }
        } catch { Write-Output "RESULT=NOT_RUN; $($_.Exception.Message)" }
        finally { Remove-Item $stdoutPath,$stderrPath -Force -ErrorAction SilentlyContinue }
    }
    Invoke-Bounded 'Flutter analyze' (Get-Command flutter).Source @('analyze','--fatal-infos','--fatal-warnings')
    Invoke-Bounded 'Dart format verification' (Get-Command dart).Source @('format','--output=none','--set-exit-if-changed','.')
    Write-Output "`n=== Forbidden navigation source scan ==="
    $dartFiles = Get-ChildItem lib,test -Recurse -File -Filter '*.dart'
    $navigation = $dartFiles | Select-String -Pattern 'Navigator\.of'
    if ($navigation) { $navigation | ForEach-Object { '{0}:{1}: {2}' -f $_.Path,$_.LineNumber,$_.Line.Trim() }; Write-Output 'FAIL: forbidden usage found.' }
    else { Write-Output 'PASS: no Navigator.of matches in lib/ or test/.' }
    Invoke-Bounded 'Serial Flutter test suite' (Get-Command flutter).Source @('test','--concurrency=1')
    Invoke-Bounded 'Strict template validation' (Get-Command powershell).Source @('-NoProfile','-ExecutionPolicy','Bypass','-File',(Join-Path $projectRoot 'scripts/validateTemplates.ps1'),'--strict','--show-all','--no-color')
    Write-Output "`nNOT RUN: flutter pub get (may alter pubspec.lock/.dart_tool); generators/builds/check wrappers (mutating)."
    Write-Output "Review elapsed: $((Get-Date)-$started)"
} finally { Pop-Location }
