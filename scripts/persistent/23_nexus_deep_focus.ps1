# 🚀 NEXUS DEEP FOCUS SIMULATOR (V1.0)
# Optimizes system for deep research and writing

Write-Host "[*] Activating Deep Focus Mode..." -ForegroundColor Green

# 1. Stop high-CPU telemetry and background services
$ServicesToStop = @("DiagTrack", "SysMain", "WSearch", "dmwappushservice")
foreach ($svc in $ServicesToStop) {
    if ((Get-Service $svc -ErrorAction SilentlyContinue).Status -eq 'Running') {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Write-Host "[-] Stopped service: $svc" -ForegroundColor Gray
    }
}

# 2. Boost process priority for Antigravity and Chrome
$HeavyProcesses = @("Antigravity", "chrome")
foreach ($p in $HeavyProcesses) {
    Get-Process $p -ErrorAction SilentlyContinue | ForEach-Object {
        $_.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::AboveNormal
        Write-Host "[+] Boosted priority for: $p" -ForegroundColor Cyan
    }
}

# 3. Suppress Windows Notifications (Focus Assist)
# This is a registry tweak for Focus Assist (1 = Priority only, 2 = Alarms only)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_TOASTS_ENABLED" -Value 0 -ErrorAction SilentlyContinue

Write-Host "[OK] Deep Focus Active. Your PC is now optimized for the Thesis." -ForegroundColor Green
