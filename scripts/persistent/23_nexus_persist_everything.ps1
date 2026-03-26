# NEXUS OMNI-PERSISTENCE: ESCUDO DE CONTINUIDAD V2
# Robust startup script for persistence

$ScriptsDir = "C:\Users\Lenovo\improved-parakeet\scripts\persistent"

Write-Host "`n[*] INICIALIZANDO NEXUS PERSISTENCE..." -ForegroundColor Magenta

# 0. TURBO MODE: Optimize RAM and Services FIRST
Write-Host "[*] Paso 0: NEXUS TURBO (Optimización de RAM)..." -ForegroundColor Red
Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File $ScriptsDir\23_nexus_turbo.ps1"
Start-Sleep -Seconds 3

# 1. Launch Persistent Chrome (Debugging Port 9222)
Write-Host "[*] Paso 1: Lanzador de Chrome..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-WindowStyle Hidden -Command python $ScriptsDir\23_chrome_persistent_launcher.py"

# 2. Setup PM2 Services (Bridge, SSH Tunnel, Sniper)
Write-Host "[*] Paso 2: Gestor de Servicios PM2..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-WindowStyle Hidden -Command python $ScriptsDir\23_nexus_service_manager.py"

# 3. Initial Memory Sync to Obsidian
Write-Host "[*] Paso 3: Sincronizacion de Memoria (Obsidian)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-WindowStyle Hidden -Command python $ScriptsDir\23_sync_to_obsidian.py"

# 4. Start Panic Shield and Health Shield in Background
Write-Host "[*] Paso 4: Activando Escudos (Pánico y Salud)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File $ScriptsDir\00_Unified_Panic_Shield.ps1"
Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File $ScriptsDir\23_nexus_health_shield.ps1"

Write-Host "`n[DONE] TODO EL ECOSISTEMA NEXUS ESTA AHORA EN MODO PERSISTENTE." -ForegroundColor Cyan
Write-Host "[!] Puedes cerrar Antigravity o reiniciar la sesion; el bridge y los tuneles seguiran vivos." -ForegroundColor White
