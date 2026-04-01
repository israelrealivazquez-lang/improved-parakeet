# 🧹 NEXUS RETENTION MANAGER (V1.0)
$brainPath = "C:\Users\Lenovo\ANTIGRAVITY_CORE\antigravity\brain"
$limitMB = 100

Write-Host "Checking browser_recordings size..." -ForegroundColor Cyan

$recordings = Get-ChildItem -Path $brainPath -Filter "*.webp" -Recurse
$totalSize = ($recordings | Measure-Object -Property Length -Sum).Sum / 1MB

if ($totalSize -gt $limitMB) {
    Write-Host "Total size ($([math]::Round($totalSize, 2)) MB) exceeds limit ($limitMB MB). Purging oldest files..." -ForegroundColor Yellow
    $recordings | Sort-Object LastWriteTime | Select-Object -First ($recordings.Count / 2) | Remove-Item -Force
    Write-Host "Purge complete." -ForegroundColor Green
}
else {
    Write-Host "Total size ($([math]::Round($totalSize, 2)) MB) is within limits." -ForegroundColor Gray
}
