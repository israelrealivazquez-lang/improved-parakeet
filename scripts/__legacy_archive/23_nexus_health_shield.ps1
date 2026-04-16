# 🛡️ NEXUS HEALTH SHIELD (V1.0)
# Monitors System Resources and provides silent background alerts

$DiskThresholdGB = 2.0
$RAMThresholdPercent = 90

function Show-Notification {
    param([string]$Title, [string]$Message)
    Add-Type -AssemblyName System.Windows.Forms
    $global:notification = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -Id $pid).Path
    $global:notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $global:notification.BalloonTipIcon = "Warning"
    $global:notification.BalloonTipText = $Message
    $global:notification.BalloonTipTitle = $Title
    $global:notification.Visible = $true
    $global:notification.ShowBalloonTip(10000)
    Start-Sleep -Seconds 10
    $global:notification.Dispose()
}

while ($true) {
    # 1. Check Disk
    $drive = Get-PSDrive C
    $freeGB = $drive.Free / 1GB
    if ($freeGB -lt $DiskThresholdGB) {
        Show-Notification -Title "CRITICAL DISK LOW" -Message "Only $([math]::round($freeGB, 2)) GB remaining on C: drive. Clear space now!"
    }

    # 2. Check RAM
    $mem = Get-CimInstance Win32_OperatingSystem
    $totalMem = $mem.TotalVisibleMemorySize
    $freeMem = $mem.FreePhysicalMemory
    $usedPercent = (($totalMem - $freeMem) / $totalMem) * 100
    if ($usedPercent -gt $RAMThresholdPercent) {
        Show-Notification -Title "HIGH RAM USAGE" -Message "RAM usage is at $([math]::round($usedPercent, 2))%. Consider closing background apps."
    }

    # Check every 5 minutes
    Start-Sleep -Seconds 300
}
