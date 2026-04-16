import subprocess
import json
import os
import time
import requests

# 🔱 NEXUS MESH ORCHESTRATOR (V1.0)
# This script runs on the LOCAL PC to manage all Codespaces.

REGISTRY_PATH = "nexus_mesh_registry.json"

def list_codespaces():
    """Use gh CLI to list codespaces."""
    try:
        cmd = ["gh", "codespace", "list", "--json", "name,repository,state,displayName"]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return json.loads(result.stdout)
    except Exception as e:
        print(f"[!] Failed to list codespaces: {e}")
        return []

def wake_codespace(name):
    """Wake up a codespace if it's shutdown."""
    print(f"[*] Waking up node: {name}...")
    try:
        # Just running a command triggers a wake-up if configured, 
        # but 'gh codespace ssh' or similar is more direct.
        # Here we use 'gh codespace ports' which ensures visibility.
        subprocess.run(["gh", "codespace", "ports", "-c", name], timeout=10)
    except:
        pass

def orchestrate():
    print("=== NEXUS MESH STATUS ===")
    cs_list = list_codespaces()
    
    # Priority: 16GB Nodes first
    cs_list.sort(key=lambda x: "16GB" in x.get("machineDisplayName", ""), reverse=True)
    
    for cs in cs_list:
        status = cs['state']
        display = cs['displayName']
        name = cs['name']
        repo = cs['repository']
        
        print(f"- {name} [{repo}] | {status} | {display}")
        
        if status == "Shutdown" and "glowing" in display.lower():
            print(f"  [!] Master node is Offline. Recommended: 'gh codespace resume -c {name}'")

if __name__ == "__main__":
    orchestrate()
