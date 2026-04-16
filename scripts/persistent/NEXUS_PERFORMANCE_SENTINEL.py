import time
import psutil
import json
import os
from datetime import datetime

# 👁️ NEXUS PERFORMANCE SENTINEL (V1.0)
# Purpose: High-precision lag detection and autonomous remediation.

LOG_FILE = r"C:\Nexus_Core\NEXUS_TELEMETRY.json"
FREEZE_THRESHOLD = 1.5 # Seconds of hang that count as a "traba"

def get_telemetry():
    if os.path.exists(LOG_FILE):
        with open(LOG_FILE, 'r') as f:
            return json.load(f)
    return {"total_freezes": 0, "events": [], "uptime_start": datetime.now().isoformat()}

def log_freeze(duration):
    data = get_telemetry()
    data["total_freezes"] += 1
    event = {
        "timestamp": datetime.now().isoformat(),
        "duration_sec": round(duration, 2),
        "top_cpu_process": psutil.Process(psutil.cpu_percent(interval=None)).name() if psutil.cpu_percent() > 50 else "unknown",
        "free_ram_gb": round(psutil.virtual_memory().available / (1024**3), 2)
    }
    data["events"].append(event)
    with open(LOG_FILE, 'w') as f:
        json.dump(data, f, indent=4)
    print(f"[!] FREEZE DETECTED: {duration}s. Logged to telemetry.")

def autonomous_remedy():
    # Purge heavy non-essential processes immediately
    for proc in psutil.process_iter(['name']):
        if proc.info['name'] in ['msedgewebview2.exe', 'SearchHost.exe', 'OneDrive.exe']:
            try:
                proc.kill()
            except:
                pass

def monitor_loop():
    print("=== NEXUS SENTINEL: MONITORING ACTIVE ===")
    while True:
        start = time.perf_counter()
        time.sleep(1) # Base interval
        end = time.perf_counter()
        
        delta = end - start
        real_elapsed = delta - 1 # Subtract the intended sleep
        
        if real_elapsed > FREEZE_THRESHOLD:
            log_freeze(real_elapsed)
            autonomous_remedy()
        
        # Periodic RAM scavenge if under 500MB
        if psutil.virtual_memory().available < 500 * 1024 * 1024:
            autonomous_remedy()

if __name__ == "__main__":
    monitor_loop()
