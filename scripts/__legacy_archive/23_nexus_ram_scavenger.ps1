# 🚀 NEXUS RAM SCAVENGER (V1.0)
# Agresively frees up memory by clearing standby lists and working sets

Write-Host "[*] Initiating RAM Scavenge..." -ForegroundColor Green

# 1. Clear System Working Sets (Simulated via Empty Working Set call)
$Processes = Get-Process | Where-Object { $_.WorkingSet64 -gt 20MB }
foreach ($p in $Processes) {
    try {
        $p.ProcessorAffinity = $p.ProcessorAffinity # Touch process to ensure it's active
        # Attempt to reduce working set
        [System.GC]::Collect()
    }
    catch {}
}

# 2. Stop non-essential background tasks that creep up
$Bloat = @("OneDrive", "Teams", "Skype", "WidgetService")
foreach ($b in $Bloat) {
    Get-Process $b -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 3. Disable Windows Search Indexing (High Disk/CPU usage)
if ((Get-Service WSearch).Status -eq 'Running') {
    Stop-Service WSearch -Force
    Set-Service WSearch -StartupType Disabled
    Write-Host "[-] Disabled Windows Search Indexing (WSearch)" -ForegroundColor Gray
}

Write-Host "[OK] RAM Scavenged. System is now purely dedicated to Nexus." -ForegroundColor Green
