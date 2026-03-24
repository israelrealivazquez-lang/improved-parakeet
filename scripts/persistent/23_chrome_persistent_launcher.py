import subprocess
import os
import sys
import time

# Configuration
CHROME_PATH = r"C:\Users\Lenovo\AppData\Local\Google\Chrome\Application\chrome.exe"
PROFILE_DIR = "Profile 6"
REMOTE_PORT = 9222
USER_DATA_DIR = os.path.join(os.environ['LOCALAPPDATA'], 'Google', 'Chrome', 'User Data')

def launch_persistent_chrome(urls=[]):
    """
    Launches Chrome in a detached process on Windows to ensure it lives
    beyond the calling terminal/Antigravity session.
    """
    print(f"[*] Launching persistent Chrome (Profile: {PROFILE_DIR}) at port {REMOTE_PORT}...")
    
    # Check if Chrome is already running on that port
    # (Simple check: try to connect or just launch and let it handle)
    
    args = [
        CHROME_PATH,
        f"--remote-debugging-port={REMOTE_PORT}",
        f"--profile-directory={PROFILE_DIR}",
        f"--user-data-dir={USER_DATA_DIR}",
        "--no-first-run",
        "--no-default-browser-check",
        "--restore-last-session"
    ]
    
    if urls:
        args.extend(urls)

    try:
        # Using subprocess.DETACHED_PROCESS to decouple from the current terminal
        process = subprocess.Popen(
            args,
            creationflags=subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP,
            close_fds=True
        )
        print(f"[+] Chrome launched with PID: {process.pid}. It will stay alive if you close Antigravity.")
        return True
    except Exception as e:
        print(f"[!] Error launching Chrome: {e}")
        return False

if __name__ == "__main__":
    test_urls = [
        "https://chatgpt.com",
        "https://claude.ai/new",
        "https://gemini.google.com/app"
    ]
    launch_persistent_chrome(test_urls)
