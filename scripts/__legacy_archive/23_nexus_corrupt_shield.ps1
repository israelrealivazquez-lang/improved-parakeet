# 🛡️ NEXUS CORRUPTION SHIELD (SSD PROTECTION)
# Monitors critical files for silent data corruption (Hash-Based)

$CriticalFiles = @(
    "C:\Users\Lenovo\.gemini\antigravity\brain\04b8239d-7b2e-47d3-8986-8ad290f4265b\nexus_master_memory.md",
    "C:\Users\Lenovo\improved-parakeet\scripts\persistent\23_nexus_persist_everything.ps1",
    "C:\Users\Lenovo\improved-parakeet\scripts\persistent\23_nexus_service_manager.py"
)

$HashStorePath = "D:\antigravity_memory\file_hashes.json"

function Get-StoredHashes {
    if (Test-Path $HashStorePath) {
        return Get-Content $HashStorePath | ConvertFrom-Json
    }
    return @{}
}

function Update-Hashes {
    $Hashes = @{}
    foreach ($file in $CriticalFiles) {
        if (Test-Path $file) {
            $Hashes[$file] = (Get-FileHash -Path $file -Algorithm SHA256).Hash
        }
    }
    $Hashes | ConvertTo-Json | Out-File $HashStorePath -Force
}

function Check-Corruption {
    $StoredHashes = Get-StoredHashes
    if ($StoredHashes.Count -eq 0) {
        Write-Host "[!] No existing hashes. Creating baseline..." -ForegroundColor Yellow
        Update-Hashes
        return
    }

    foreach ($file in $CriticalFiles) {
        if (Test-Path $file) {
            $CurrentHash = (Get-FileHash -Path $file -Algorithm SHA256).Hash
            if ($StoredHashes.psobject.Properties[$file] -and $StoredHashes.$file -ne $CurrentHash) {
                # Potential Corruption Detected
                Write-Host "[🚨] CORRUPTION DETECTED: $file" -ForegroundColor Red
                # If we had a backup, we would restore here. For now, alert!
            }
        }
    }
}

# Run Check
Check-Corruption

# Schedule baseline update every month (or manually)
# Update-Hashes
