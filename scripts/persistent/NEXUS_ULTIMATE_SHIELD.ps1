# 🔱 NEXUS ULTIMATE SHIELD (V1.0) - CONSOLIDATED INFRASTRUCTURE
# Merges: MegaOptimizer, RAMScavenger, Turbo, Sentinel, and HealthShield.
# Purpose: Transform 4GB PC into a frictionless Monitor/Node.

$ErrorActionPreference = "SilentlyContinue"

Write-Host "=== NEXUS ULTIMATE CORE SHIELD ACTIVATED ===" -ForegroundColor Cyan

# ═══════════════════════════════════════════
# 1. PERMANENT SANITIZATION (Process Control)
# ═══════════════════════════════════════════
function Sanitize-System {
    Write-Host "[*] Purging redundant processes and bloatware..." -ForegroundColor Green
    $bloat = @('SearchApp', 'SearchHost', 'YourPhone', 'PhoneExperienceHost', 'GameBar', 'GameBarPresenceWriter', 'MicrosoftEdgeUpdate', 'WidgetService', 'Teams', 'SkypeApp', 'OneDrive', 'msedgewebview2')
    foreach ($p in $bloat) {
        Get-Process -Name $p | Stop-Process -Force 2>$null
    }
    
    # Disable non-essential services permanently
    $services = @('WSearch', 'SysMain', 'DiagTrack', 'MapsBroker', 'WerSvc')
    foreach ($s in $services) {
        Stop-Service -Name $s -Force | Out-Null
        Set-Service -Name $s -StartupType Disabled | Out-Null
    }
}

# ═══════════════════════════════════════════
# 2. RAM SCAVENGER (Memory Management)
# ═══════════════════════════════════════════
function Scavenge-RAM {
    Write-Host "[*] Reclaiming RAM for Antigravity..." -ForegroundColor Yellow
    [System.GC]::Collect()
    Get-Process | Where-Object { $_.WorkingSet64 -gt 100MB -and $_.Name -notin @('Antigravity', 'chrome', 'Code', 'powershell') } | ForEach-Object {
        $_.PriorityClass = 'BelowNormal'
    }
}

# ═══════════════════════════════════════════
# 3. CLOUD-DRIVE OPTIMIZATION (Disk Space)
# ═══════════════════════════════════════════
function Optimize-Drive {
    Write-Host "[*] Purging local Drive cache (Online-Only Mode)..." -ForegroundColor Magenta
    # Remove local temp/cache files from common sync apps
    $cachePaths = @("$env:LOCALAPPDATA\Google\DriveFS", "$env:LOCALAPPDATA\Microsoft\OneDrive\cache")
    foreach ($path in $cachePaths) {
        if (Test-Path $path) {
            Remove-Item "$path\*" -Recurse -Force 2>$null
        }
    }
}

# ═══════════════════════════════════════════
# 4. OFFLOAD STATUS (Cloud Bridge)
# ═══════════════════════════════════════════
function Check-Offload {
    Write-Host "[*] Verifying Cloud Bridge (Colab/GitHub)..." -ForegroundColor Blue
    if (Test-Path "c:\Users\Lenovo\improved-parakeet\scripts\local_mesh_connector.py") {
        python "c:\Users\Lenovo\improved-parakeet\scripts\local_mesh_connector.py"
    }
}

# ═══════════════════════════════════════════
# MAIN LOOP (Sentinel Mode)
# ═══════════════════════════════════════════
Sanitize-System
Optimize-Drive
Check-Offload

# Final Health Check
$freeRAM = [math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1024 / 1024, 2)
$freeC = [math]::Round((Get-PSDrive C).Free / 1GB, 2)
Write-Host "`n=== NEXUS STATE ===" -ForegroundColor Cyan
Write-Host "[RAM] $freeRAM GB Free" -ForegroundColor Green
Write-Host "[DISK] $freeC GB Free" -ForegroundColor Green
Write-Host "[STATUS] Ready for Thin-Client Operation." -ForegroundColor Cyan
