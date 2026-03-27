# 🔄 NEXUS SHADOW SYNC (V1.0)
# Robust mirroring between USB (D:) and Google Drive (Streaming)

$Source = "D:\nexus_work"
$Target = "C:\Users\Lenovo\Streaming de Google Drive\Mi unidad\NEXUS_ULTIMATE_THESIS"
$Registry = "c:\Users\Lenovo\improved-parakeet\nexus_mesh_registry.json"

if (!(Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force
}

Write-Host "[*] Starting Shadow Sync (Mirroring)..." -ForegroundColor Cyan

# Use Robocopy for high reliability and delta sync for thesis work
robocopy $Source $Target /MIR /Z /R:5 /W:5 /MT:8 /LOG:"C:\Users\Lenovo\nexus_sync.log" /NP

# Sync Mesh Registry to Drive for persistent cloud access
$DriveRegistry = Join-Path $Target "nexus_mesh_registry.json"
Copy-Item $Registry $DriveRegistry -Force

Write-Host "[OK] Sync Complete. Mesh Registry and Research mirrored in Google Drive." -ForegroundColor Green
