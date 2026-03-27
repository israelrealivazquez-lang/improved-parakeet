import os
import json
import time
import requests
import socket
from datetime import datetime

# 💓 NEXUS MESH HEARTBEAT (V1.0)
# This script runs in each Codespace to report its status to the Registry.

REGISTRY_PATH = "/workspaces/improved-parakeet/nexus_mesh_registry.json"
LOCAL_IP = socket.gethostbyname(socket.gethostname())
CODESPACE_NAME = os.environ.get("CODESPACE_NAME", "unknown-node")
GITHUB_REPOSITORY = os.environ.get("GITHUB_REPOSITORY", "unknown-repo")

def update_registry():
    try:
        # Note: In a real distributed system, we'd use a central API.
        # Here we assume a shared filesystem or Git-synced registry.
        if not os.path.exists(REGISTRY_PATH):
            data = {"last_update": "", "nodes": {}}
        else:
            with open(REGISTRY_PATH, "r") as f:
                data = json.load(f)
        
        data["last_update"] = datetime.now().isoformat()
        data["nodes"][CODESPACE_NAME] = {
            "ip": LOCAL_IP,
            "repo": GITHUB_REPOSITORY,
            "last_seen": datetime.now().isoformat(),
            "status": "ALIVE",
            "port": 8080
        }
        
        with open(REGISTRY_PATH, "w") as f:
            json.dump(data, f, indent=2)
            
        print(f"[*] Heartbeat sent for {CODESPACE_NAME} at {LOCAL_IP}")
    except Exception as e:
        print(f"[!] Heartbeat failed: {e}")

if __name__ == "__main__":
    print(f"Starting Nexus Heartbeat for {CODESPACE_NAME}...")
    while True:
        update_registry()
        time.sleep(300) # Every 5 minutes
