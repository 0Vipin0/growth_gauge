param(
    [string]$ExerciseFile = ".\lib\features\catalog\infrastructure\seed\exercise_seed_data.dart",
    [string]$TemplateFile = ".\lib\features\template\infrastructure\seed\workout_template_seed_data.dart"
)

if (-not (Test-Path $ExerciseFile) -or -not (Test-Path $TemplateFile)) {
    Write-Host "[ERROR] Could not find input files." -ForegroundColor Red
    Write-Host "Usage: .\validateTemplates.ps1 [-ExerciseFile <path>] [-TemplateFile <path>]"
    exit 1
}

$exerciseContent = Get-Content -Path $ExerciseFile -Raw
$templateContent = Get-Content -Path $TemplateFile -Raw

# Extract unique IDs using regex matches
$definedMatches = [regex]::Matches($exerciseContent, "id:\s*'([^']+)'")
$definedIds = $definedMatches | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique

$templateMatches = [regex]::Matches($templateContent, "exerciseId:\s*'([^']+)'")
$referencedIds = $templateMatches | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique

# Calculate set differences
$missing = $referencedIds | Where-Object { $definedIds -notcontains $_ }
$orphans = $definedIds | Where-Object { $referencedIds -notcontains $_ }

$definedCount = if ($definedIds) { @($definedIds).Count } else { 0 }
$referencedCount = if ($referencedIds) { @($referencedIds).Count } else { 0 }
$missingCount = if ($missing) { @($missing).Count } else { 0 }
$orphanCount = if ($orphans) { @($orphans).Count } else { 0 }

# Display Formatted Table Summary
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host " EXERCISE & TEMPLATE VALIDATION SUMMARY (PowerShell)                    " -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan

$summary = [PSCustomObject[]] @(
    [PSCustomObject]@{ Metric = "Total Defined Exercises"; Count = $definedCount; Details = "Loaded from Exercise Seed Catalog" },
    [PSCustomObject]@{ Metric = "Total Referenced Exercises"; Count = $referencedCount; Details = "Unique IDs used across Workout Templates" },
    [PSCustomObject]@{ Metric = "Missing Exercises"; Count = $missingCount; Details = $(if($missingCount -gt 0){"Action Required: Missing from catalog"}else{"All referenced exercises exist"}) },
    [PSCustomObject]@{ Metric = "Orphan Exercises"; Count = $orphanCount; Details = "Defined in catalog but currently unused in templates" }
)

$summary | Format-Table -AutoSize

Write-Host "========================================================================" -ForegroundColor Cyan

# Validation check exit codes
if ($missingCount -gt 0) {
    Write-Host "VALIDATION FAILED: The following exercise IDs are missing from the catalog:" -ForegroundColor Red
    foreach ($id in $missing) {
        Write-Host "   - $id" -ForegroundColor Red
    }
    exit 1
} else {
    Write-Host "VALIDATION PASSED: Every template reference is valid!" -ForegroundColor Green
    exit 0
}