@echo off
:: 🔱 NEXUS AUTO-STABILIZER
:: Ensures the 4GB RAM Thin-Client stays fast after reboot.

echo [*] Re-engaging NEXUS ULTIMATE SHIELD...
powershell -ExecutionPolicy Bypass -File "C:\Users\Lenovo\improved-parakeet\scripts\persistent\NEXUS_ULTIMATE_SHIELD.ps1"

echo [*] Launching Performance Sentinel...
start /min py "C:\Users\Lenovo\improved-parakeet\scripts\persistent\NEXUS_PERFORMANCE_SENTINEL.py"

echo [*] Synchronizing Cloud Bridges...
start /min py "C:\Users\Lenovo\improved-parakeet\scripts\persistent\NEXUS_GRID_ORCHESTRATOR.py" --sentinel

echo [+] NEXUS IS ARMED AND READY.
timeout /t 5
