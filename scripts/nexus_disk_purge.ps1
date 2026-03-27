# 🧹 NEXUS DISK PURGE (V1.0)
# Emergency cleanup for low-disk systems (PhD Edition)

Write-Host "[*] Starting Emergency Disk Purge..." -ForegroundColor Yellow

# 1. Clean Tempoary Files
$TempFolders = @(
    "$env:TEMP\*",
    "$env:SystemRoot\Temp\*",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Profile 6\Cache\*"
)

foreach ($folder in $TempFolders) {
    Write-Host "[*] Purging: $folder" -ForegroundColor Cyan
    Remove-Item -Path $folder -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Clean Windows Update Cache (SoftwareDistribution)
# Note: Stopping the service first is safer but we'll try a direct delete of the Download folder
Write-Host "[*] Clearing Windows Update cache..." -ForegroundColor Cyan
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue

# 3. Prefetch Cleanup
Write-Host "[*] Clearing Prefetch..." -ForegroundColor Cyan
Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

# 4. Check Free Space
$C = Get-PSDrive C
$FreeGB = [math]::Round($C.Free / 1GB, 2)
Write-Host "[OK] Disk Purge Complete. Free Space on C: $FreeGB GB" -ForegroundColor Green
