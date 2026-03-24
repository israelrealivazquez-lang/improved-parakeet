import os
import sys
import datetime

# Obsidian Infinite Memory Sync Script
# Integrates research logs into an Obsidian Vault

# Configuration
OBSIDIAN_VAULT_PATH = r"C:\Users\Lenovo\OneDrive\Nexus_Core\Obsidian_Memory"
LOGS_DIR = r"C:\Users\Lenovo\OneDrive\Nexus_Core\GHOST_HARVEST_CHUNKS"
MASTER_MEMORY_FILE = os.path.join(OBSIDIAN_VAULT_PATH, "NEXUS_INFINITE_MEMORY.md")

def ensure_vault_exists():
    """Checks if the Obsidian vault path exists and creates it if needed."""
    if not os.path.exists(OBSIDIAN_VAULT_PATH):
        os.makedirs(OBSIDIAN_VAULT_PATH)
        print(f"[*] Created new Obsidian Vault at: {OBSIDIAN_VAULT_PATH}")

def sync_logs_to_obsidian():
    """Collects research logs and appends them to the master memory file."""
    print("[*] Sincronizando memoria infinita con Obsidian...")
    ensure_vault_exists()
    
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    header = f"\n\n## 🧠 NEXUS SYNC: {timestamp}\n"
    
    # 1. Harvest recent GHOST_HARVEST data if exists
    harvest_file = r"C:\Users\Lenovo\OneDrive\Nexus_Core\GHOST_HARVEST_2026.txt"
    content = ""
    if os.path.exists(harvest_file):
        with open(harvest_file, 'r', encoding='utf-8') as f:
            content = f.read()
    
    if content:
        with open(MASTER_MEMORY_FILE, 'a', encoding='utf-8') as f:
            f.write(header)
            f.write(content)
        print(f"[✔] Memoria actualizada en: {MASTER_MEMORY_FILE}")
    else:
        print("[!] No hay nuevos datos de cosecha para sincronizar.")

if __name__ == "__main__":
    sync_logs_to_obsidian()
