import time
import os
from datetime import datetime

# 🕯️ NEXUS KEEP-ALIVE (V1.0)
# This script prevents the Codespace from timing out by creating periodic activity.

LOG_FILE = "/workspaces/improved-parakeet/nexus_activity.log"

def sustain_life():
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG_FILE, "a") as f:
        f.write(f"[*] Persistent pulse at {timestamp}\n")
    print(f"[*] Pulse recorded at {timestamp}")

if __name__ == "__main__":
    print("Nexus Keep-Alive mode: ACTIVE")
    while True:
        sustain_life()
        time.sleep(900) # Every 15 minutes (well within the typical 30-60 min timeout)
