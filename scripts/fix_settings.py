import json
import os
import re

settings_path = os.path.expandvars(r"%APPDATA%\Code\User\settings.json")

def clean_json(content):
    # Remove single line comments
    content = re.sub(r'//.*', '', content)
    # Remove multi-line comments
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    # Remove trailing commas
    content = re.sub(r',\s*}', '}', content)
    content = re.sub(r',\s*\]', ']', content)
    return content

if os.path.exists(settings_path):
    with open(settings_path, 'r', encoding='utf-8') as f:
        raw_content = f.read()
    
    try:
        clean_data = clean_json(raw_content)
        data = json.loads(clean_data)
        
        # Add the necessary keys for Colab and Firebase
        data["jupyter.jupyterServerType"] = "remote"
        data["jupyter.pynotebook.kernelPath"] = "http://localhost:8888"
        # Potential Colab extension keys
        data["google.colab.compute.localRuntimeUrl"] = "http://localhost:8888"
        data["google.colab.compute.backendUrl"] = "http://localhost:8888"
        
        with open(settings_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4)
        print("[OK] Settings updated successfully.")
    except Exception as e:
        print(f"[!] Error: {e}")
else:
    print("[!] Settings file not found.")
