# 🔱 NEXUS TURBO (V1.0) - Persistent Startup Optimizer
# Runs at every boot to maintain peak performance on 4GB RAM.

Write-Host "=== NEXUS TURBO STARTUP ===" -ForegroundColor Cyan

# 1. Kill services that steal RAM
$services = @('WSearch', 'SysMain', 'DiagTrack', 'dmwappushservice', 'MapsBroker', 'lfsvc', 'RetailDemo')
foreach ($s in $services) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# 2. Kill bloatware processes
$killList = @('SearchApp', 'SearchHost', 'YourPhone', 'PhoneExperienceHost', 'GameBar', 'GameBarPresenceWriter', 'MicrosoftEdgeUpdate', 'WidgetService')
foreach ($proc in $killList) {
    Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 3. Clean temp
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# 4. Disable transparency and animations
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -ErrorAction SilentlyContinue

# 5. High Performance power plan
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null

# 6. Flush DNS
ipconfig /flushdns | Out-Null

# 7. Compact OS (recover space without deleting anything)
# compact /compactos:always 2>$null

$freeRAM = [math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
Write-Host "[TURBO] Free RAM: $freeRAM GB | System Optimized" -ForegroundColor Green
