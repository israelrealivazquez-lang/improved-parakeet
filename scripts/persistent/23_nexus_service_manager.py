import subprocess
import os
import sys
import time

# Robust PM2 Service Manager for Nexus Core
# Solves Unicode issues and ensures service survival

def run_pm2_command(args):
    """Executes a PM2 command and handles encoding silently."""
    cmd = ["pm2"] + args
    
    # Suppression for Windows
    startupinfo = None
    creationflags = 0
    if os.name == 'nt':
        startupinfo = subprocess.STARTUPINFO()
        startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        startupinfo.wShowWindow = 0 # SW_HIDE
        creationflags = subprocess.CREATE_NO_WINDOW

    try:
        process = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, encoding='utf-8',
            startupinfo=startupinfo, creationflags=creationflags
        )
        return process.stdout
    except Exception as e:
        process = subprocess.run(
            cmd, shell=True, capture_output=True, text=True,
            startupinfo=startupinfo, creationflags=creationflags
        )
        return process.stdout

def setup_pm2_services():
    """Configures the core persistence services."""
    print("[*] Iniciando configuración de servicios persistentes (PM2)...")
    
    # Paths (using absolute paths in the workspace)
    scripts_dir = r"C:\Users\Lenovo\improved-parakeet\scripts\persistent"
    bridge_script = os.path.join(r"C:\Users\Lenovo\OneDrive\.antigravity_nexus\.gemini\antigravity\ops", "browser_bridge.py")
    
    # 1. Browser Bridge
    print("[+] Registrando Browser Bridge...")
    run_pm2_command(["start", f'"{bridge_script}"', "--name", "nexus-bridge", "--restart-delay", "3000"])
    
    # 2. SSH Tunnel to Mothership
    # Port mapping: 5678 (n8n), 11434 (Ollama), 8384 (Syncthing)
    print("[+] Configurando Túnel SSH a la Mothership...")
    ssh_cmd = 'gcloud compute ssh antigravity-nexus-master --zone us-central1-a -- -N -L 5678:localhost:5678 -L 11434:localhost:11434 -L 8384:localhost:8384'
    run_pm2_command(["start", f'"{ssh_cmd}"', "--name", "nexus-ssh-tunnel"])
    
    # 3. Oracle Sniper (if exists)
    sniper_script = os.path.join(r"C:\Users\Lenovo\OneDrive\.antigravity_nexus\.gemini\antigravity\ops", "07_oracle_sniper.py")
    if os.path.exists(sniper_script):
        print("[+] Registrando Oracle Sniper...")
        run_pm2_command(["start", f'"{sniper_script}"', "--name", "nexus-oracle-sniper"])
    
    # Save the process list
    run_pm2_command(["save"])
    print("\n[OK] SERVICIOS PERSISTENTES ACTIVADOS.") # Fix: Removed Unicode checkmark to avoid encoding errors

if __name__ == "__main__":
    setup_pm2_services()
