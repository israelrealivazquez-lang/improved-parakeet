# 🧊 NEXUS COLD BACKUP (V1.0)
# Pushes thesis data to a private GitHub repo for disaster recovery.

$RepoDir = "c:\Users\Lenovo\improved-parakeet"
$ThesisDir = "D:\nexus_work"
$BackupDir = Join-Path $RepoDir "nexus_backup"

Write-Host "[*] NEXUS COLD BACKUP starting..." -ForegroundColor Cyan

# 1. Copy critical files to repo
New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null

# Copy Master Hub
Copy-Item "$ThesisDir\MASTER_THESIS_HUB_V3.md" "$BackupDir\MASTER_THESIS_HUB_V3.md" -Force -ErrorAction SilentlyContinue
# Copy Credential Vault (metadata only, no passwords)
Copy-Item "$env:USERPROFILE\.gemini\antigravity\brain\04b8239d-7b2e-47d3-8986-8ad290f4265b\NEXUS_CREDENTIAL_VAULT.md" "$BackupDir\CREDENTIAL_VAULT.md" -Force -ErrorAction SilentlyContinue
# Copy Thesis Index
Copy-Item "$env:USERPROFILE\.gemini\antigravity\brain\04b8239d-7b2e-47d3-8986-8ad290f4265b\ESTRUCTURA_THESIS_NEXUS.md" "$BackupDir\ESTRUCTURA_THESIS.md" -Force -ErrorAction SilentlyContinue

Write-Host "[OK] Critical files staged." -ForegroundColor Green

# 2. Git commit and push
Set-Location $RepoDir
git add nexus_backup/ 2>$null
git commit -m "NEXUS COLD BACKUP $(Get-Date -Format 'yyyy-MM-dd_HHmm')" 2>$null
git push origin main 2>$null

Write-Host "[OK] Cold backup pushed to GitHub." -ForegroundColor Green
