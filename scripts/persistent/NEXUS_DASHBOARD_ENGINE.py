import os
import json
import glob

# 📊 NEXUS DASHBOARD GENERATOR
# Auto-generates a health & progress report for the CCA Thesis.

MANUSCRIPT = r"C:\Nexus_Core\TESIS_OMNI_BORRADOR_V1.md"
BIBLIOGRAPHY = r"C:\Nexus_Core\MASTER_BIBLIOGRAPHY.md"
TELEMETRY = r"C:\Nexus_Core\NEXUS_TELEMETRY.json"
DASHBOARD = r"C:\Nexus_Core\NEXUS_DASHBOARD.html"

def get_word_count(path):
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            return len(f.read().split())
    return 0

def generate_html():
    words = get_word_count(MANUSCRIPT)
    pages = round(words / 300, 1)
    refs = get_word_count(BIBLIOGRAPHY) # Simple proxy
    
    freezes = 0
    if os.path.exists(TELEMETRY):
        with open(TELEMETRY, 'r') as f:
            freezes = json.load(f).get("total_freezes", 0)

    html = f"""
    <html>
    <head>
        <title>NEXUS - CCA THESIS DASHBOARD</title>
        <style>
            body {{ font-family: 'Segoe UI', sans-serif; background: #0b0e14; color: #e0e0e0; padding: 40px; }}
            .card {{ background: #1a1f26; padding: 20px; border-radius: 10px; border-left: 5px solid #00f2ff; margin-bottom: 20px; }}
            h1 {{ color: #00f2ff; text-transform: uppercase; letter-spacing: 2px; }}
            .stat {{ font-size: 3em; font-weight: bold; color: #fff; }}
            .label {{ color: #888; text-transform: uppercase; font-size: 0.8em; }}
        </style>
    </head>
    <body>
        <h1>🔱 Nexus Infrastructure Status</h1>
        <div class="card">
            <div class="label">Manuscript Progress</div>
            <div class="stat">{words:,} Words / {pages} Pages</div>
            <div class="label">Target: 240,000 Words (800 Pages)</div>
        </div>
        <div class="card" style="border-left-color: #ff0055;">
            <div class="label">System Resilience</div>
            <div class="stat">{freezes} Freezes Neutralized</div>
            <div class="label">Sentinel Status: Active/Hidden</div>
        </div>
    </body>
    </html>
    """
    with open(DASHBOARD, 'w', encoding='utf-8') as f:
        f.write(html)

if __name__ == "__main__":
    generate_html()
