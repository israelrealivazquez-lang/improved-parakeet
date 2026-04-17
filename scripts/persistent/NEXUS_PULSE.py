import time
import requests
import psutil

# 📡 NEXUS PULSE (Multi-Cloud Health Engine)
# Services: Firebase (State) + Cloudflare (Tunnel) + GitHub (Compute)

FIREBASE_URL = "https://antigravity-pc1-auto-default-rtdb.firebaseio.com/pulse.json"

def monitor_and_anticipate():
    while True:
        cpu = psutil.cpu_percent()
        ram = psutil.virtual_memory().percent
        
        # ⚠️ Si el PC local llega al 90%, activamos el "Escudo de Nube"
        if ram > 90 or cpu > 90:
            print(f"[!] SOBRECARGA DETECTADA: CPU {cpu}% RAM {ram}%")
            print("[*] ACTIVANDO OFFLOADING TOTAL A CLOUD-SHELL...")
            # Aquí mandamos un trigger a GitHub Actions via Webhook
            requests.post(FIREBASE_URL, json={"status": "OVERLOAD", "timestamp": time.time()})
            
        time.sleep(10)

if __name__ == "__main__":
    monitor_and_anticipate()
