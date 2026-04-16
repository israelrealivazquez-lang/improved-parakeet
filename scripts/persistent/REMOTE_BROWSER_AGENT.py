import os
import json
from playwright.sync_api import sync_playwright

def run_remote_browser():
    with sync_playwright() as p:
        # Iniciamos el navegador en el servidor de GitHub (NO en tu PC)
        browser = p.chromium.launch(headless=True)
        context = browser.new_context()
        page = context.new_page()
        
        print("Navegador Fantasma: Conectando a Google Cloud Shell...")
        
        page.goto("https://www.google.com")
        print(f"Estado: Conexión Exitosa con Titulo: {page.title()}")
        
        browser.close()

if __name__ == "__main__":
    run_remote_browser()
