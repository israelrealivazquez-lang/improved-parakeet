import os
import re

def calculate_telemetry():
    paths = [
        r"C:\Users\Lenovo\OneDrive\Nexus_Core\DOC_FINAL_DRAFT.md",
        r"C:\Users\Lenovo\OneDrive\Nexus_Core\MASTER_UNIFICACION_NEXUS.md"
    ]
    
    total_words = 0
    total_chars = 0
    
    print("="*60)
    print(" 📊 NEXUS TELEMETRY DASHBOARD - PRODUCTION READY")
    print("="*60)
    
    for p in paths:
        if os.path.exists(p):
            with open(p, 'r', encoding='utf-8') as f:
                content = f.read()
                words = len(re.findall(r'\w+', content))
                chars = len(content)
                total_words += words
                total_chars += chars
                print(f" [FILE] {os.path.basename(p)}: {words} words | {chars} chars")
    
    # Target: 350 pages ~ 105,000 words (300 words/page)
    target_words = 105000
    completion = (total_words / target_words) * 100
    
    print("-"*60)
    print(f" TOTAL PROGRESS: {total_words:,} / {target_words:,} words")
    print(f" COMPLETION: {completion:.2f}%")
    print(f" PAGES ESTIMATE: {total_words / 300:.1f} pages")
    print("="*60)

if __name__ == "__main__":
    calculate_telemetry()
