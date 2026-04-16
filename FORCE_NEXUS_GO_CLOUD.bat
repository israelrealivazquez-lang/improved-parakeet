@echo off
:: 🔱 EMERGENCY CLOUD SWITCH
:: Usage: Run this when the PC is stuttering.

echo [!] EMERGENCY DETECTED: TRANSITIONING TO CLOUD TERMINAL...

:: 1. Force release local indexing (VS Code search/watcher)
powershell -Command "Get-Process -Name 'rg', 'node' -ErrorAction SilentlyContinue | Stop-Process -Force"

:: 2. Launch the Cloud Shell Terminal (which has 16GB RAM)
start chrome "https://console.cloud.google.com/cloudshell/editor?project=nexus-doctoral-thesis"

:: 3. Scavenge RAM one last time
powershell -ExecutionPolicy Bypass -File "C:\Users\Lenovo\improved-parakeet\scripts\persistent\NEXUS_ULTIMATE_SHIELD.ps1"

echo [✓] Local PC is now just a MONITOR. 
echo [✓] All work shifted to Google Cloud Terminal.
pause
