<#
.SYNOPSIS
    Validates that every exercise referenced by the workout templates exists in
    the exercise catalog, runs integrity checks on both seed files, and prints a
    tabular summary of the current exercise and template data.

.PARAMETER ExerciseFile
    Path to exercise_seed_data.dart

.PARAMETER TemplateFile
    Path to workout_template_seed_data.dart

.PARAMETER Strict
    Treat warnings as failures (exit code 1).

.PARAMETER ShowAll
    Also print the full exercise usage table.

.PARAMETER NoColor
    Disable coloured output.

.EXAMPLE
    .\validateTemplates.ps1
    .\validateTemplates.ps1 .\exercise_seed_data.dart .\workout_template_seed_data.dart -Strict -ShowAll

.NOTES
    Exit codes: 0 = passed, 1 = validation failed, 2 = usage / input error.
    Works on Windows PowerShell 5.1 and PowerShell 7+.
#>
param(
    [string]$ExerciseFile = ".\lib\features\catalog\infrastructure\seed\exercise_seed_data.dart",
    [string]$TemplateFile = ".\lib\features\template\infrastructure\seed\workout_template_seed_data.dart",
    [switch]$Strict,
    [switch]$ShowAll,
    [switch]$NoColor
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
function Out-Line {
    param([string]$Text, [string]$Color = '')
    if ($Color -and -not $NoColor) { Write-Host $Text -ForegroundColor $Color } else { Write-Host $Text }
}

function New-OrdinalSet { return , (New-Object 'System.Collections.Generic.HashSet[string]' -ArgumentList ([System.StringComparer]::Ordinal)) }
function New-OrdinalCounter { return , (New-Object 'System.Collections.Generic.Dictionary[string,int]' -ArgumentList ([System.StringComparer]::Ordinal)) }
function Add-Count { param($Dict, [string]$Key) if ($Dict.ContainsKey($Key)) { $Dict[$Key] = $Dict[$Key] + 1 } else { $Dict[$Key] = 1 } }

function Sort-Ordinal {
    param([string[]]$Items)
    $arr = [string[]]@($Items)
    [System.Array]::Sort($arr, [System.StringComparer]::Ordinal)
    return , $arr
}

function Get-Quoted {
    param([string]$Line, [string]$Key)
    $pattern = '(^|[^A-Za-z0-9_])' + $Key + ':\s*(?:''((?:\\.|[^''\\])*)''|"((?:\\.|[^"\\])*)")'
    $m = [regex]::Match($Line, $pattern)
    if (-not $m.Success) { return '' }
    if ($m.Groups[2].Success) { $v = $m.Groups[2].Value } else { $v = $m.Groups[3].Value }
    return [regex]::Replace($v, '\\(.)', '$1')
}

function Get-Dupes {
    param([string[]]$Values)
    $counter = New-OrdinalCounter
    foreach ($v in $Values) { if ($null -ne $v -and $v -ne '') { Add-Count $counter $v } }
    $out = New-Object System.Collections.Generic.List[object]
    foreach ($k in (Sort-Ordinal @($counter.Keys))) {
        if ($counter[$k] -gt 1) { $out.Add([pscustomobject]@{ Value = $k; Count = $counter[$k] }) }
    }
    return , $out
}

function Write-Table {
    param(
        [string]$Title,
        [string[]]$Headers,
        $Rows,
        [string]$Align = '',
        [int]$MaxWidth = 48
    )
    if ($Title) { Write-Host ''; Write-Host " $Title" }
    if ($null -eq $Rows -or $Rows.Count -eq 0) { Write-Host ' (none)'; return }

    $colCount = $Headers.Count
    $widths = New-Object 'int[]' $colCount
    $fit = {
        param([string]$s)
        if ($null -eq $s) { $s = '' }
        if ($s.Length -gt $MaxWidth) { return $s.Substring(0, $MaxWidth - 3) + '...' }
        return $s
    }
    for ($c = 0; $c -lt $colCount; $c++) { $widths[$c] = $Headers[$c].Length }
    $cells = New-Object System.Collections.Generic.List[object]
    foreach ($row in $Rows) {
        $fitted = New-Object 'string[]' $colCount
        for ($c = 0; $c -lt $colCount; $c++) {
            $fitted[$c] = & $fit ([string]$row[$c])
            if ($fitted[$c].Length -gt $widths[$c]) { $widths[$c] = $fitted[$c].Length }
        }
        $cells.Add($fitted)
    }
    $sep = '+'
    for ($c = 0; $c -lt $colCount; $c++) { $sep += ('-' * ($widths[$c] + 2)) + '+' }

    Write-Host $sep
    $line = '|'
    for ($c = 0; $c -lt $colCount; $c++) { $line += ' ' + $Headers[$c].PadRight($widths[$c]) + ' |' }
    Write-Host $line
    Write-Host $sep
    foreach ($fitted in $cells) {
        $line = '|'
        for ($c = 0; $c -lt $colCount; $c++) {
            $al = 'l'
            if ($Align.Length -gt $c) { $al = $Align.Substring($c, 1) }
            if ($al -eq 'r') { $line += ' ' + $fitted[$c].PadLeft($widths[$c]) + ' |' }
            else { $line += ' ' + $fitted[$c].PadRight($widths[$c]) + ' |' }
        }
        Write-Host $line
    }
    Write-Host $sep
}

function Get-IdTokens {
    param([string]$Id)
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($p in ($Id -split '-')) {
        if ($p -ne '' -and $p -cne 'exercise' -and $p -notmatch '^[0-9]+$') { $out.Add($p) }
    }
    return , $out
}

# ---------------------------------------------------------------------------
# Locate input files
# ---------------------------------------------------------------------------
function Find-Seed {
    param([string]$Name)
    $hit = Get-ChildItem -Path . -Recurse -Filter $Name -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '[\\/](build|\.dart_tool|\.git|node_modules)[\\/]' } |
        Select-Object -First 1
    if ($hit) { return $hit.FullName }
    return $null
}

if (-not (Test-Path -LiteralPath $ExerciseFile -PathType Leaf) -and -not $PSBoundParameters.ContainsKey('ExerciseFile')) {
    $found = Find-Seed 'exercise_seed_data.dart'
    if ($found) { $ExerciseFile = $found }
}
if (-not (Test-Path -LiteralPath $TemplateFile -PathType Leaf) -and -not $PSBoundParameters.ContainsKey('TemplateFile')) {
    $found = Find-Seed 'workout_template_seed_data.dart'
    if ($found) { $TemplateFile = $found }
}

$exerciseFound = Test-Path -LiteralPath $ExerciseFile -PathType Leaf
$templateFound = Test-Path -LiteralPath $TemplateFile -PathType Leaf
if (-not $exerciseFound -or -not $templateFound) {
    Out-Line '[ERROR] Could not find input files.' 'Red'
    $exStatus = if ($exerciseFound) { '(found)' } else { '(NOT FOUND)' }
    $tpStatus = if ($templateFound) { '(found)' } else { '(NOT FOUND)' }
    Write-Host "        Exercise file: $ExerciseFile $exStatus"
    Write-Host "        Template file: $TemplateFile $tpStatus"
    Write-Host 'Usage: .\validateTemplates.ps1 [-ExerciseFile <path>] [-TemplateFile <path>] [-Strict] [-ShowAll] [-NoColor]'
    exit 2
}

# ---------------------------------------------------------------------------
# Parse exercise seed file
# ---------------------------------------------------------------------------
function Read-ExerciseFile {
    param([string]$Path)
    $rawLines = [System.IO.File]::ReadAllLines((Resolve-Path -LiteralPath $Path).ProviderPath)
    $lines = @(foreach ($l in $rawLines) { $l.TrimEnd("`r") })
    $exercises = New-Object System.Collections.Generic.List[object]
    $declared = New-Object System.Collections.Generic.List[string]
    $registered = New-Object System.Collections.Generic.List[string]
    $reDecl = [regex]'static final (_[A-Za-z0-9_]+) = (Exercise|_movement)\('
    $reTok = [regex]'(EquipmentType|BodyRegion|MovementPattern|MuscleGroup)\.([A-Za-z0-9_]+)'
    $inAll = $false
    $cur = $null
    $coll = ''

    $close = {
        param($c)
        $miss = New-Object System.Collections.Generic.List[string]
        if (-not $c.HasSetup) { $miss.Add('setup') }
        if (-not $c.HasExec) { $miss.Add('execution') }
        if (-not $c.HasCues) { $miss.Add('cues') }
        if (-not $c.HasBreath) { $miss.Add('breathing') }
        $equip = @($c.Lists['equip'])
        if (-not $c.HasEquip -and $c.IsMove) { $equip = @('bodyweight') }
        $exercises.Add([pscustomobject]@{
            Id        = $c.Id
            Name      = $c.Name
            Equipment = $equip
            Regions   = @($c.Lists['region'])
            Patterns  = @($c.Lists['pattern'])
            Primary   = @($c.Lists['primary'])
            Missing   = @($miss)
            Var       = $c.Var
        })
        $declared.Add($c.Var)
    }

    foreach ($line in $lines) {
        if ($line -cmatch 'get all => \[') { $inAll = $true; continue }
        if ($inAll) {
            if ($line -cmatch '^  \];') { $inAll = $false; continue }
            $rm = [regex]::Match($line, '^\s*(_[A-Za-z0-9_]+),')
            if ($rm.Success) { $registered.Add($rm.Groups[1].Value) }
            continue
        }
        $dm = $reDecl.Match($line)
        if ($dm.Success) {
            if ($null -ne $cur) { & $close $cur }
            $cur = @{
                Var = $dm.Groups[1].Value; IsMove = ($dm.Groups[2].Value -ceq '_movement')
                Id = ''; Name = ''; HasEquip = $false
                HasSetup = $false; HasExec = $false; HasCues = $false; HasBreath = $false
                Lists = @{
                    equip   = New-Object System.Collections.Generic.List[string]
                    region  = New-Object System.Collections.Generic.List[string]
                    pattern = New-Object System.Collections.Generic.List[string]
                    primary = New-Object System.Collections.Generic.List[string]
                }
            }
            $coll = ''
            continue
        }
        if ($null -eq $cur) { continue }

        if ($cur.Id -eq '' -and $line -cmatch '(^|[^A-Za-z0-9_])id:') { $cur.Id = Get-Quoted $line 'id' }
        if ($cur.Name -eq '' -and $line -cmatch '^\s*name:') { $cur.Name = Get-Quoted $line 'name' }

        $k = ''
        if ($line -cmatch '^\s*(bodyRegions|regions):') { $k = 'region' }
        elseif ($line -cmatch '^\s*(movementPatterns|patterns):') { $k = 'pattern' }
        elseif ($line -cmatch '^\s*(primaryMuscles|primary):') { $k = 'primary' }
        elseif ($line -cmatch '^\s*(requiredEquipment|equipment):') { $k = 'equip'; $cur.HasEquip = $true }
        if ($k -ne '') { $coll = $k }
        if ($coll -ne '') {
            foreach ($tm in $reTok.Matches($line)) { $cur.Lists[$coll].Add($tm.Groups[2].Value) }
            if ($line.Contains(']')) { $coll = '' }
        }

        if ($line -cmatch '^\s*(setupInstructions|setup):') { $cur.HasSetup = $true }
        if ($line -cmatch '^\s*(executionInstructions:|execution:\s*(const\s*)?\[)') { $cur.HasExec = $true }
        if ($line -cmatch '^\s*(techniqueCues|cues):') { $cur.HasCues = $true }
        if ($line -cmatch '^\s*(breathingInstructions|breathing):') { $cur.HasBreath = $true }

        if ($line -cmatch '^  \);\s*$') { & $close $cur; $cur = $null; $coll = '' }
    }
    if ($null -ne $cur) { & $close $cur }

    return [pscustomobject]@{ Exercises = $exercises; Declared = $declared; Registered = $registered }
}

# ---------------------------------------------------------------------------
# Parse template seed file
# ---------------------------------------------------------------------------
function Read-TemplateFile {
    param([string]$Path)
    $rawLines = [System.IO.File]::ReadAllLines((Resolve-Path -LiteralPath $Path).ProviderPath)
    $lines = @(foreach ($l in $rawLines) { $l.TrimEnd("`r") })
    $templates = New-Object System.Collections.Generic.List[object]
    $refs = New-Object System.Collections.Generic.List[object]
    $nested = New-Object System.Collections.Generic.List[object]
    $zero = New-Object System.Collections.Generic.List[object]
    $declared = New-Object System.Collections.Generic.List[string]
    $registered = New-Object System.Collections.Generic.List[string]
    $reDecl = [regex]'static final (_[A-Za-z0-9_]+) = TemplateSeedBundle\('
    $reNid = [regex]'id:\s*''((block|item|ts)-[^'']*)'''
    $inAll = $false
    $cur = $null
    $idx = 0

    $close = {
        param($c)
        $templates.Add([pscustomobject]@{
            Idx = $c.Idx; Var = $c.Var; Id = $c.Id; Name = $c.Name; CurRev = $c.CurRev
            RevId = $c.RevId; RevTplId = $c.RevTplId
            Blocks = $c.Blocks; Items = $c.Items; Sets = $c.Sets; Unique = $c.Seen.Count
        })
        $declared.Add($c.Var)
    }

    foreach ($line in $lines) {
        if ($line -cmatch 'get all => \[') { $inAll = $true; continue }
        if ($inAll) {
            if ($line -cmatch '^  \];') { $inAll = $false; continue }
            $rm = [regex]::Match($line, '^\s*(_[A-Za-z0-9_]+),')
            if ($rm.Success) { $registered.Add($rm.Groups[1].Value) }
            continue
        }
        $dm = $reDecl.Match($line)
        if ($dm.Success) {
            if ($null -ne $cur) { & $close $cur }
            $idx++
            $cur = @{
                Idx = $idx; Var = $dm.Groups[1].Value; Id = ''; Name = ''; CurRev = ''; RevId = ''; RevTplId = ''
                St = ''; Blocks = 0; Items = 0; Sets = 0; Seen = (New-OrdinalSet)
            }
            continue
        }
        if ($null -eq $cur) { continue }

        if ($line -cmatch 'WorkoutTemplateRevision\(') { $cur.St = 'rev' }
        elseif ($line -cmatch 'WorkoutTemplate\(') { $cur.St = 'tpl' }
        if ($line -cmatch 'WorkoutBlock\(') { $cur.St = 'blk' }

        if ($cur.St -eq 'tpl') {
            if ($cur.Id -eq '') { $cur.Id = Get-Quoted $line 'id' }
            if ($cur.Name -eq '') { $cur.Name = Get-Quoted $line 'name' }
            if ($cur.CurRev -eq '') { $cur.CurRev = Get-Quoted $line 'currentRevisionId' }
        }
        elseif ($cur.St -eq 'rev') {
            if ($cur.RevId -eq '') { $cur.RevId = Get-Quoted $line 'id' }
            if ($cur.RevTplId -eq '') { $cur.RevTplId = Get-Quoted $line 'templateId' }
        }

        $cur.Blocks += [regex]::Matches($line, 'WorkoutBlock\(').Count
        $cur.Items += [regex]::Matches($line, 'TemplateItem\(').Count
        $cur.Sets += [regex]::Matches($line, 'TargetSet\(').Count

        foreach ($nm in $reNid.Matches($line)) {
            $nested.Add([pscustomobject]@{ Kind = $nm.Groups[2].Value; Id = $nm.Groups[1].Value; Idx = $cur.Idx })
        }

        $ex = Get-Quoted $line 'exerciseId'
        if ($ex -ne '') {
            $comment = ''
            $ci = $line.IndexOf('//')
            if ($ci -ge 0) { $comment = $line.Substring($ci + 2).Trim() }
            $refs.Add([pscustomobject]@{ Idx = $cur.Idx; Template = $cur.Name; ExerciseId = $ex; Comment = $comment })
            [void]$cur.Seen.Add($ex)
        }
        if ($line -cmatch 'targetReps:\s*0([^0-9.]|$)') {
            $zero.Add([pscustomobject]@{ Idx = $cur.Idx; Template = $cur.Name })
        }

        if ($line -cmatch '^  \);\s*$') { & $close $cur; $cur = $null }
    }
    if ($null -ne $cur) { & $close $cur }

    return [pscustomobject]@{
        Templates = $templates; Refs = $refs; Nested = $nested; Zero = $zero
        Declared = $declared; Registered = $registered
    }
}

$exData = Read-ExerciseFile $ExerciseFile
$tpData = Read-TemplateFile $TemplateFile
$exercises = $exData.Exercises
$templates = $tpData.Templates
$refs = $tpData.Refs

if ($exercises.Count -eq 0) { Out-Line "[ERROR] No exercise definitions were found in: $ExerciseFile" 'Red'; exit 2 }
if ($templates.Count -eq 0) { Out-Line "[ERROR] No template definitions were found in: $TemplateFile" 'Red'; exit 2 }

# ---------------------------------------------------------------------------
# Core analysis
# ---------------------------------------------------------------------------
$defSet = New-OrdinalSet
foreach ($e in $exercises) { if ($e.Id -ne '') { [void]$defSet.Add($e.Id) } }
$usedSet = New-OrdinalSet
foreach ($r in $refs) { [void]$usedSet.Add($r.ExerciseId) }

$defIds = @(Sort-Ordinal @($defSet))
$usedIds = @(Sort-Ordinal @($usedSet))
$missingIds = @($usedIds | Where-Object { -not $defSet.Contains($_) })
$orphanIds = @($defIds | Where-Object { -not $usedSet.Contains($_) })

$defCount = $defSet.Count
$usedCount = $usedSet.Count
$missingCount = $missingIds.Count
$orphanCount = $orphanIds.Count
$tplCount = $templates.Count
$missingRefs = @($refs | Where-Object { -not $defSet.Contains($_.ExerciseId) }).Count
$blocks = 0; $items = 0; $sets = 0
foreach ($t in $templates) { $blocks += $t.Blocks; $items += $t.Items; $sets += $t.Sets }

# Duplicates and integrity
$issues = New-Object System.Collections.Generic.List[object]
function Add-DupIssues {
    param([string]$Label, [string[]]$Values)
    $d = Get-Dupes $Values
    foreach ($x in $d) { $issues.Add([pscustomobject]@{ Issue = $Label; Value = $x.Value; Detail = ('{0} occurrences' -f $x.Count) }) }
    return $d.Count
}
$dupExId = Add-DupIssues 'Exercise ID' @($exercises | ForEach-Object { $_.Id })
$dupExName = Add-DupIssues 'Exercise name' @($exercises | ForEach-Object { $_.Name })
$dupTplId = Add-DupIssues 'Template ID' @($templates | ForEach-Object { $_.Id })
$dupTplName = Add-DupIssues 'Template name' @($templates | ForEach-Object { $_.Name })
$dupRev = Add-DupIssues 'Revision ID' @($templates | ForEach-Object { $_.RevId })
$dupNested = 0
foreach ($kind in @('block', 'item', 'ts')) {
    $dupNested += Add-DupIssues ("Nested ID ($kind)") @($tpData.Nested | Where-Object { $_.Kind -ceq $kind } | ForEach-Object { $_.Id })
}
$dupVars = Add-DupIssues 'Static variable' @(@($exData.Declared) + @($tpData.Declared))

$revMismatch = @($templates | Where-Object { ($_.CurRev -cne $_.RevId) -or ($_.Id -cne $_.RevTplId) }).Count

function Get-SetDiff {
    param([string[]]$A, [string[]]$B)
    $bs = New-OrdinalSet
    foreach ($x in $B) { [void]$bs.Add($x) }
    return @($A | Where-Object { -not $bs.Contains($_) })
}
$exUnreg = @(Sort-Ordinal @(Get-SetDiff @($exData.Declared) @($exData.Registered)))
$exUndecl = @(Sort-Ordinal @(Get-SetDiff @($exData.Registered) @($exData.Declared)))
$tpUnreg = @(Sort-Ordinal @(Get-SetDiff @($tpData.Declared) @($tpData.Registered)))
$tpUndecl = @(Sort-Ordinal @(Get-SetDiff @($tpData.Registered) @($tpData.Declared)))
foreach ($v in $exUnreg) { $issues.Add([pscustomobject]@{ Issue = 'Exercise not in all[]'; Value = $v; Detail = 'declared but never registered' }) }
foreach ($v in $exUndecl) { $issues.Add([pscustomobject]@{ Issue = 'Exercise all[] entry'; Value = $v; Detail = 'registered but not declared' }) }
foreach ($v in $tpUnreg) { $issues.Add([pscustomobject]@{ Issue = 'Template not in all[]'; Value = $v; Detail = 'declared but never registered' }) }
foreach ($v in $tpUndecl) { $issues.Add([pscustomobject]@{ Issue = 'Template all[] entry'; Value = $v; Detail = 'registered but not declared' }) }

$incomplete = @($exercises | Where-Object { $_.Missing.Count -gt 0 })
$zeroSets = $tpData.Zero.Count

# ---------------------------------------------------------------------------
# Validation checks
# ---------------------------------------------------------------------------
$script:errors = 0
$script:warnings = 0
$checks = New-Object System.Collections.Generic.List[string[]]
function Add-Check {
    param([string]$Name, [string]$Type, [int]$Count, [string]$FailDetail, [string]$OkDetail)
    $result = 'PASS'
    $detail = $OkDetail
    if ($Count -gt 0) {
        $detail = $FailDetail
        if ($Type -eq 'ERROR') { $result = 'FAIL'; $script:errors++ } else { $result = 'WARN'; $script:warnings++ }
    }
    $checks.Add([string[]]@($Name, $Type, $result, [string]$Count, $detail))
}

Add-Check 'Template exercise refs exist in catalog' 'ERROR' $missingCount "$missingCount missing ID(s) across $missingRefs reference(s)" "All $usedCount referenced IDs resolve"
Add-Check 'Exercise IDs unique' 'ERROR' $dupExId 'Duplicate exercise IDs found' 'No duplicates'
Add-Check 'Exercise definitions registered in all[]' 'ERROR' ($exUnreg.Count + $exUndecl.Count) "$($exUnreg.Count) unregistered, $($exUndecl.Count) undeclared" "$($exercises.Count) declared = registered"
Add-Check 'Template IDs unique' 'ERROR' $dupTplId 'Duplicate template IDs found' 'No duplicates'
Add-Check 'Revision IDs unique and consistent' 'ERROR' ($dupRev + $revMismatch) "$dupRev duplicate, $revMismatch inconsistent" 'Revision links are consistent'
Add-Check 'Block/item/set IDs unique' 'ERROR' $dupNested 'Duplicate nested IDs found' 'No duplicates'
Add-Check 'Template definitions registered in all[]' 'ERROR' ($tpUnreg.Count + $tpUndecl.Count) "$($tpUnreg.Count) unregistered, $($tpUndecl.Count) undeclared" "$tplCount declared = registered"
Add-Check 'Static variable names unique' 'ERROR' $dupVars 'Duplicate declarations (compile error)' 'No duplicates'
Add-Check 'Template names unique' 'WARN' $dupTplName 'Duplicate template names found' 'No duplicates'
Add-Check 'Exercise names unique' 'WARN' $dupExName 'Duplicate exercise names found' 'No duplicates'
Add-Check 'Exercises used by templates' 'WARN' $orphanCount "$orphanCount defined but never referenced" 'Every exercise is used'
Add-Check 'Exercise execution profiles complete' 'WARN' $incomplete.Count "$($incomplete.Count) exercise(s) missing setup/execution/cues/breathing" 'All profiles complete'
Add-Check 'Sets with targetReps: 0' 'WARN' $zeroSets "$zeroSets set(s) have a zero rep target" 'None found'

# ---------------------------------------------------------------------------
# Output
# ---------------------------------------------------------------------------
$banner = '========================================================================'
Out-Line $banner 'Cyan'
Out-Line ' EXERCISE & TEMPLATE VALIDATION SUMMARY (PowerShell)' 'Cyan'
Out-Line $banner 'Cyan'
Write-Host " Exercise file : $ExerciseFile"
Write-Host " Template file : $TemplateFile"

Write-Table -Title 'VALIDATION CHECKS' -Headers @('Check', 'Type', 'Result', 'Count', 'Details') -Rows $checks -Align 'lllrl' -MaxWidth 60

$overview = New-Object System.Collections.Generic.List[string[]]
$missingDetail = 'All referenced exercises exist'
if ($missingCount -gt 0) { $missingDetail = 'Action required: referenced but not in catalog' }
$overview.Add([string[]]@('Exercises defined (catalog)', [string]$defCount, 'Unique IDs in exercise seed data'))
$overview.Add([string[]]@('Exercises referenced (distinct)', [string]$usedCount, 'Unique IDs used across workout templates'))
$overview.Add([string[]]@('Missing exercises', [string]$missingCount, $missingDetail))
$overview.Add([string[]]@('Orphan exercises', [string]$orphanCount, 'Defined in catalog but not used by any template'))
$overview.Add([string[]]@('Workout templates', [string]$tplCount, 'Template bundles in template seed data'))
$overview.Add([string[]]@('Workout blocks', [string]$blocks, 'Across all templates'))
$overview.Add([string[]]@('Exercise slots (items)', [string]$items, 'Total exercise references, including repeats'))
$overview.Add([string[]]@('Target sets', [string]$sets, 'Across all templates'))
Write-Table -Title 'DATA OVERVIEW' -Headers @('Metric', 'Count', 'Details') -Rows $overview -Align 'lrl' -MaxWidth 60

function Write-CategoryTable {
    param([string]$Title, [string]$Label, [string]$Property)
    $total = New-OrdinalCounter
    $usedC = New-OrdinalCounter
    foreach ($e in $exercises) {
        foreach ($c in @($e.$Property)) {
            Add-Count $total $c
            if ($usedSet.Contains($e.Id)) { Add-Count $usedC $c }
        }
    }
    $rowsObj = foreach ($c in $total.Keys) {
        $u = 0
        if ($usedC.ContainsKey($c)) { $u = $usedC[$c] }
        [pscustomobject]@{ Name = $c; Total = $total[$c]; Used = $u }
    }
    $sorted = @($rowsObj | Sort-Object @{ Expression = { $_.Total }; Descending = $true }, @{ Expression = { $_.Name }; Descending = $false })
    $rows = New-Object System.Collections.Generic.List[string[]]
    foreach ($r in $sorted) { $rows.Add([string[]]@($r.Name, [string]$r.Total, [string]$r.Used, [string]($r.Total - $r.Used))) }
    Write-Table -Title $Title -Headers @($Label, 'Exercises', 'Used', 'Unused') -Rows $rows -Align 'lrrr' -MaxWidth 40
}
Write-CategoryTable 'EXERCISE CATALOG BY EQUIPMENT (an exercise counts once per equipment type)' 'Equipment' 'Equipment'
Write-CategoryTable 'EXERCISE CATALOG BY BODY REGION' 'Body Region' 'Regions'
Write-CategoryTable 'EXERCISE CATALOG BY MOVEMENT PATTERN' 'Movement Pattern' 'Patterns'
Write-CategoryTable 'EXERCISE CATALOG BY PRIMARY MUSCLE' 'Primary Muscle' 'Primary'

# Template table
$missingPerTpl = New-OrdinalCounter
foreach ($r in $refs) { if (-not $defSet.Contains($r.ExerciseId)) { Add-Count $missingPerTpl ([string]$r.Idx) } }
$tplRows = New-Object System.Collections.Generic.List[string[]]
foreach ($t in $templates) {
    $status = 'OK'
    $key = [string]$t.Idx
    if ($missingPerTpl.ContainsKey($key)) { $status = '{0} missing' -f $missingPerTpl[$key] }
    $tplRows.Add([string[]]@([string]$t.Idx, $t.Name, [string]$t.Blocks, [string]$t.Items, [string]$t.Sets, [string]$t.Unique, $status))
}
Write-Table -Title 'WORKOUT TEMPLATES' -Headers @('#', 'Template', 'Blocks', 'Items', 'Sets', 'Unique Ex', 'Refs') -Rows $tplRows -Align 'rlrrrrl' -MaxWidth 46

# Missing exercises with closest-match suggestions
if ($missingCount -gt 0) {
    $missRows = New-Object System.Collections.Generic.List[string[]]
    foreach ($id in $missingIds) {
        $refList = @($refs | Where-Object { $_.ExerciseId -ceq $id })
        $names = New-Object System.Collections.Generic.List[string]
        foreach ($r in $refList) { if (-not $names.Contains($r.Template)) { $names.Add($r.Template) } }
        $shown = @($names | Select-Object -First 2) -join '; '
        if ($names.Count -gt 2) { $shown += (' (+{0} more)' -f ($names.Count - 2)) }

        $mt = Get-IdTokens $id
        $best = '-'
        $bestScore = 0.0
        foreach ($d in $defIds) {
            $dt = Get-IdTokens $d
            $shared = 0
            foreach ($a in $mt) { if ($dt.Contains($a)) { $shared++ } }
            $union = $mt.Count + $dt.Count - $shared
            $score = 0.0
            if ($union -gt 0) { $score = [double]$shared / [double]$union }
            if ($score -gt $bestScore) { $bestScore = $score; $best = $d }
        }
        if ($bestScore -lt 0.4) { $best = '-' }
        $missRows.Add([string[]]@($id, [string]$refList.Count, $shown, $best))
    }
    Write-Table -Title 'MISSING EXERCISES (referenced by templates, absent from catalog)' -Headers @('Missing Exercise ID', 'Refs', 'Referenced By', 'Closest Catalog Match') -Rows $missRows -Align 'lrll' -MaxWidth 56
}

# Integrity issues
if ($issues.Count -gt 0) {
    $issueRows = New-Object System.Collections.Generic.List[string[]]
    $sortedIssues = @($issues | Sort-Object -Property @{ Expression = { $_.Issue } }, @{ Expression = { $_.Value } })
    foreach ($i in $sortedIssues) { $issueRows.Add([string[]]@($i.Issue, $i.Value, $i.Detail)) }
    Write-Table -Title 'INTEGRITY ISSUES' -Headers @('Issue', 'Value', 'Detail') -Rows $issueRows -Align 'lll' -MaxWidth 56
}

# Incomplete execution profiles
if ($incomplete.Count -gt 0) {
    $incRows = New-Object System.Collections.Generic.List[string[]]
    foreach ($e in @($incomplete | Sort-Object -Property Id)) { $incRows.Add([string[]]@($e.Id, ($e.Missing -join ','))) }
    Write-Table -Title 'INCOMPLETE EXECUTION PROFILES' -Headers @('Exercise ID', 'Missing Fields') -Rows $incRows -Align 'll' -MaxWidth 56
}

# Zero-rep sets per template
if ($zeroSets -gt 0) {
    $zc = New-OrdinalCounter
    foreach ($z in $tpData.Zero) { Add-Count $zc $z.Template }
    $zRows = New-Object System.Collections.Generic.List[string[]]
    foreach ($n in (Sort-Ordinal @($zc.Keys))) { $zRows.Add([string[]]@($n, [string]$zc[$n])) }
    Write-Table -Title 'SETS WITH ZERO REP TARGET (review)' -Headers @('Template', 'Sets with targetReps: 0') -Rows $zRows -Align 'lr' -MaxWidth 56
}

# Usage per exercise
$tplPerEx = New-OrdinalCounter
$seenPair = New-OrdinalSet
foreach ($r in $refs) {
    $pair = '{0}|{1}' -f $r.ExerciseId, $r.Idx
    if ($seenPair.Add($pair)) { Add-Count $tplPerEx $r.ExerciseId }
}
$usageRows = New-Object System.Collections.Generic.List[object]
foreach ($e in $exercises) {
    $n = 0
    if ($tplPerEx.ContainsKey($e.Id)) { $n = $tplPerEx[$e.Id] }
    $usageRows.Add([pscustomobject]@{ Id = $e.Id; Name = $e.Name; Equip = ($e.Equipment -join ','); Count = $n })
}
$usageSorted = @($usageRows | Sort-Object -Property Id)
if ($ShowAll) {
    $rows = New-Object System.Collections.Generic.List[string[]]
    foreach ($u in $usageSorted) { $rows.Add([string[]]@($u.Id, $u.Name, $u.Equip, [string]$u.Count)) }
    Write-Table -Title 'EXERCISE USAGE (all exercises)' -Headers @('Exercise ID', 'Name', 'Equipment', 'Templates') -Rows $rows -Align 'lllr' -MaxWidth 44
}
elseif ($orphanCount -gt 0) {
    $limit = 25
    $orph = @($usageSorted | Where-Object { $_.Count -eq 0 })
    $rows = New-Object System.Collections.Generic.List[string[]]
    foreach ($u in @($orph | Select-Object -First $limit)) { $rows.Add([string[]]@($u.Id, $u.Name, $u.Equip, [string]$u.Count)) }
    Write-Table -Title 'ORPHAN EXERCISES (defined, not used in any template)' -Headers @('Exercise ID', 'Name', 'Equipment', 'Templates') -Rows $rows -Align 'lllr' -MaxWidth 44
    if ($orphanCount -gt $limit) { Write-Host (' ... and {0} more (use -ShowAll to list every exercise)' -f ($orphanCount - $limit)) }
}

Write-Host ''
Out-Line $banner 'Cyan'
$strictNote = ''
if ($Strict) { $strictNote = '   (strict mode: warnings fail the run)' }
Out-Line (' Errors: {0}   Warnings: {1}{2}' -f $script:errors, $script:warnings, $strictNote) 'Cyan'
Out-Line $banner 'Cyan'

# ---------------------------------------------------------------------------
# Exit status
# ---------------------------------------------------------------------------
if ($missingCount -gt 0) {
    Out-Line 'VALIDATION FAILED: The following exercise IDs are missing from the catalog:' 'Red'
    foreach ($id in $missingIds) { Out-Line "   - $id" 'Red' }
}
if ($script:errors -gt 0 -or ($Strict -and $script:warnings -gt 0)) {
    if ($missingCount -eq 0) {
        $what = 'FAIL'
        if ($Strict) { $what = 'FAIL / WARN' }
        Out-Line "VALIDATION FAILED: see the checks marked $what above." 'Red'
    }
    exit 1
}
Out-Line 'VALIDATION PASSED: Every template reference is valid!' 'Green'
exit 0