# 🔱 NEXUS OMEGA: GITHUB COLD STORAGE CHECKPOINT
# This script monitors the thesis file and pushes to GitHub every 500 words.

param (
    [string]$thesisPath = "C:\Users\Lenovo\improved-parakeet\MASTER_THESIS_HUB_V4.md",
    [int]$wordThreshold = 100
)

function Get-WordCount($path) {
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        return ($content.Split(" `t`n`r", [StringSplitOptions]::RemoveEmptyEntries)).Length
    }
    return 0
}

# Load last count from a small temp file
$stateFile = "C:\Users\Lenovo\nexus_backup_state.txt"
$lastCount = 0
if (Test-Path $stateFile) {
    $lastCount = [int](Get-Content $stateFile)
}

$currentCount = Get-WordCount $thesisPath
$diff = $currentCount - $lastCount

Write-Host "Current word count: $currentCount"
Write-Host "Difference since last backup: $diff"

if ($diff -ge $wordThreshold) {
    Write-Host "[🔱] THRESHOLD REACHED: Backing up to GitHub..." -ForegroundColor Cyan
    
    # 1. Store the new count locally
    $currentCount | Out-File $stateFile -Force
    
    # 2. Add and push with a specialized message
    Set-Location "c:\Users\Lenovo\improved-parakeet"
    git add $thesisPath 2>$null
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "🔱 NEXUS COLD BACKUP: Thesis Milestone (V4.x) - $timestamp" 1>$null 2>$null
    git push origin main 1>$null 2>$null
    
    Write-Host "[OK] Backup successful: Milestone reached." -ForegroundColor Green
}
else {
    Write-Host "Next backup in $([math]::Max(0,$wordThreshold - $diff)) words." -ForegroundColor Gray
}
