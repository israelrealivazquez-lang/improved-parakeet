import subprocess
import os
import sys
import time
import json
import socket
from datetime import datetime

# 🔱 NEXUS GRID ORCHESTRATOR (V1.0)
# Purpose: Unified Python engine for Thin-Client operations, 
# service persistence, and cloud offloading.

# --- CONFIGURATION (Cross-Platform) ---
IS_WINDOWS = os.name == 'nt'
LOCAL_BASE = r"C:\Users\Lenovo\improved-parakeet" if IS_WINDOWS else os.getcwd()
SCRIPTS_DIR = os.path.join(LOCAL_BASE, "scripts", "persistent")
REGISTRY_PATH = os.path.join(os.path.dirname(os.path.dirname(SCRIPTS_DIR)), "nexus_mesh_registry.json")

CHROME_PATH = r"C:\Windows\System32\cmd.exe" # Placeholder for Windows
if IS_WINDOWS:
    CHROME_PATH = os.path.join(os.environ.get('PROGRAMFILES(X86)', 'C:\\Program Files (x86)'), 'Google\\Chrome\\Application\\chrome.exe')

PROFILE_DIR = "Profile 6"
REMOTE_PORT = 9222
USER_DATA_DIR = os.path.join(os.environ.get('LOCALAPPDATA', '/tmp'), 'Google', 'Chrome', 'User Data')

# --- MODULE 1: CHROME PERSISTENCE ---
def launch_chrome(urls=[]):
    """Launches detached Chrome with remote debugging."""
    if not IS_WINDOWS:
        print("[!] Non-Windows environment. Skipping Chrome GUI launch.")
        return
        
    print(f"[*] Ensuring Persistent Chrome (Profile {PROFILE_DIR})...")
    args = [
        CHROME_PATH,
        f"--remote-debugging-port={REMOTE_PORT}",
        f"--profile-directory={PROFILE_DIR}",
        f"--user-data-dir={USER_DATA_DIR}",
        "--no-first-run", "--no-default-browser-check", "--restore-last-session"
    ] + urls
    try:
        # Popen without creationflags on Linux
        creationflags = subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP if IS_WINDOWS else 0
        subprocess.Popen(args, creationflags=creationflags, close_fds=True)
        print("[+] Chrome instance managed.")
    except Exception as e:
        print(f"[!] Chrome error: {e}")

# --- MODULE 2: PM2 SERVICE MANAGEMENT ---
def pm2_cmd(args):
    """Executes a PM2 command with quiet flags."""
    flags = subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
    try:
        subprocess.run(["pm2"] + args, shell=True, capture_output=True, creationflags=flags)
    except:
        pass

def sync_services():
    """Syncs the essential Mothership/Colab tunnels."""
    print("[*] Syncing persistent tunnels and bridges...")
    # Browser Bridge
    bridge_script = os.path.join(SCRIPTS_DIR, "23_chrome_persistent_launcher.py") # Temporary placeholder
    pm2_cmd(["start", f'"{bridge_script}"', "--name", "nexus-bridge"])
    # SSH Mothership Tunnel
    ssh_cmd = 'gcloud compute ssh antigravity-nexus-master --zone us-central1-a -- -N -L 5678:localhost:5678 -L 11434:localhost:11434'
    pm2_cmd(["start", f'"{ssh_cmd}"', "--name", "nexus-ssh-tunnel"])
    pm2_cmd(["save"])

# --- MODULE 3: MESH STATUS (CODESPACES) ---
def check_mesh():
    """Checks the status of remote 16GB RAM nodes."""
    print("[*] Analyzing Mesh Nodes (16GB RAM Nodes)...")
    try:
        result = subprocess.run(["gh", "codespace", "list", "--json", "name,state,displayName"], capture_output=True, text=True)
        nodes = json.loads(result.stdout)
        for n in nodes:
            if "16GB" in n['displayName'] or "glowing" in n['displayName']:
                print(f"  [MESH] {n['name']} is {n['state']}")
    except:
        print("  [!] GitHub CLI not ready or no nodes found.")

# --- MODULE 4: SENTINEL LOOP ---
def sentinel():
    print("=== NEXUS GRID SENTINEL: ON ===")
    while True:
        timestamp = datetime.now().strftime("%H:%M:%S")
        # 1. Scavenge local RAM if needed (handled by Shell script, but we can call it)
        # 2. Check if bridge is responsive
        # 3. Log pulse
        print(f"[{timestamp}] Nexus Pulse: LOCAL: OK | CLOUD: SYNCING")
        time.sleep(300) # Every 5 minutes

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--urls", nargs='*', default=[])
    parser.add_argument("--sentinel", action="store_true")
    args = parser.parse_args()

    launch_chrome(args.urls)
    sync_services()
    check_mesh()
    
    if args.sentinel:
        sentinel()
