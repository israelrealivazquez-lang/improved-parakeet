# 🛡️ NEXUS SENTINEL WATCHDOG (V1.0)
# Monitors system health and auto-saves work during heavy automation

$LogPath = "C:\Users\Lenovo\nexus_sentinel.log"
$ThresholdRAM = 90 # %
$ThresholdDisk = 1000 # MB

Write-Host "[*] Sentinel Watchdog Active. Monitoring..." -ForegroundColor Cyan

while ($true) {
    # 1. Check RAM usage
    $Ram = Get-Counter '\Memory\% Committed Bytes In Use'
    $RamValue = [math]::round($Ram.CounterSamples.CookedValue, 2)
    
    # 2. Check Disk Space (C:)
    $Disk = Get-PSDrive C
    $DiskFreeMB = [math]::round($Disk.Free / 1MB, 2)

    if ($RamValue -gt $ThresholdRAM -or $DiskFreeMB -lt $ThresholdDisk) {
        Write-Host "[!] ALERT: Resource Crisis Detected!" -ForegroundColor Red
        # EMERGENCY: Kill Chrome to prevent hard crash
        Stop-Process -Name chrome -Force -ErrorAction SilentlyContinue
        
        $msg = "[$(Get-Date)] EMERGENCY SHUTDOWN: RAM $RamValue%, Disk $DiskFreeMB MB. Chrome killed to save OS."
        Add-Content -Path $LogPath -Value $msg
        
        # Trigger popup
        $msgbox = New-Object -ComObject WScript.Shell
        $msgbox.Popup("NEXUS SENTINEL: Crisis de Recursos. Chrome detenido para evitar pantallazo azul.", 10, "Alerta Nexus", 48)
        
        break # Stop watchdog for manual intervention
    }

    Start-Sleep -Seconds 30
}
