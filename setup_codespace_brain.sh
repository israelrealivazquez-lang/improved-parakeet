#!/bin/bash
# 🔱 NEXUS CODESPACE BRAIN (V1.0)
# This script runs INSIDE the GitHub Codespace to offload all heavy work from the local 4GB PC.
# Usage: After creating the Codespace, run: bash setup_codespace_brain.sh

echo "=== NEXUS CODESPACE BRAIN SETUP ==="

# 1. Install dependencies
pip install python-docx playwright psutil aiohttp 2>/dev/null
pip install yt-dlp 2>/dev/null
playwright install chromium 2>/dev/null

# 2. Create the offloading server (receives work from local PC)
cat > /workspaces/improved-parakeet/codespace_brain_server.py << 'PYEOF'
import json
import os
import asyncio
from aiohttp import web

OUTPUT_DIR = "/workspaces/improved-parakeet/nexus_output"
os.makedirs(OUTPUT_DIR, exist_ok=True)

async def handle_harvest(request):
    """Receive harvest data from local PC and process it."""
    data = await request.json()
    action = data.get("action", "store")
    
    if action == "store":
        filename = data.get("filename", "capture.md")
        content = data.get("content", "")
        filepath = os.path.join(OUTPUT_DIR, filename)
        with open(filepath, "w") as f:
            f.write(content)
        return web.json_response({"status": "ok", "file": filepath})
    
    elif action == "fuse":
        # Run the Librarian fusion in the cloud
        import glob
        hub = os.path.join(OUTPUT_DIR, "MASTER_THESIS_HUB_CLOUD.md")
        with open(hub, "w") as f:
            f.write("# NEXUS CLOUD MASTER HUB\n\n")
            for md in glob.glob(os.path.join(OUTPUT_DIR, "*.md")):
                if md != hub:
                    with open(md) as src:
                        f.write(f"## {os.path.basename(md)}\n{src.read()}\n---\n")
        return web.json_response({"status": "fused", "file": hub})
    
    elif action == "status":
        files = os.listdir(OUTPUT_DIR)
        return web.json_response({"files": len(files), "list": files[:20]})
    
    return web.json_response({"error": "unknown action"}, status=400)

app = web.Application()
app.router.add_post("/brain", handle_harvest)
app.router.add_get("/brain/status", lambda r: web.json_response({"alive": True}))

if __name__ == "__main__":
    print("[*] NEXUS CODESPACE BRAIN running on port 8080...")
    web.run_app(app, port=8080)
PYEOF

# 3. Create the local connector script (runs on user's PC)
cat > /workspaces/improved-parakeet/local_brain_connector.py << 'PYEOF'
import requests
import sys
import os

# This script runs on your LOCAL PC to send work to the Codespace brain.
# Set CODESPACE_URL to your forwarded port URL from GitHub Codespaces.

CODESPACE_URL = os.environ.get("CODESPACE_URL", "http://localhost:8080")

def send_to_brain(action, **kwargs):
    try:
        payload = {"action": action, **kwargs}
        r = requests.post(f"{CODESPACE_URL}/brain", json=payload, timeout=30)
        print(f"[OK] Brain response: {r.json()}")
        return r.json()
    except Exception as e:
        print(f"[!] Brain offline: {e}")
        return None

def check_brain():
    try:
        r = requests.get(f"{CODESPACE_URL}/brain/status", timeout=5)
        print(f"[OK] Brain is ALIVE: {r.json()}")
        return True
    except:
        print("[!] Brain is OFFLINE")
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "status":
        check_brain()
    elif len(sys.argv) > 1 and sys.argv[1] == "fuse":
        send_to_brain("fuse")
    else:
        print("Usage: python local_brain_connector.py [status|fuse]")
PYEOF

echo "[OK] Codespace Brain server created."
echo "[OK] Local connector script created."
echo ""
echo "=== TO START: python codespace_brain_server.py ==="
echo "=== Then forward port 8080 in the Ports tab ==="
