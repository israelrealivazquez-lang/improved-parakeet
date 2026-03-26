# 🔄 NEXUS SHADOW SYNC (V1.0)
# Robust mirroring between USB (D:) and Google Drive (Streaming)

$Source = "D:\nexus_work"
$Target = "C:\Users\Lenovo\Streaming de Google Drive\Mi unidad\NEXUS_ULTIMATE_THESIS"

if (!(Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force
}

Write-Host "[*] Starting Shadow Sync (Mirroring)..." -ForegroundColor Cyan

# Use Robocopy for high reliability and delta sync
robocopy $Source $Target /MIR /Z /R:5 /W:5 /MT:8 /LOG:"C:\Users\Lenovo\nexus_sync.log" /NP

Write-Host "[OK] Sync Complete. Your research is now mirrored in Google Drive." -ForegroundColor Green
