from browser_use.browser.browser import Browser, BrowserConfig
from browser_use import Agent
import asyncio
import os
from langchain_google_genai import ChatGoogleGenerativeAI

# 🔱 NEXUS BROWSER BRIDGE
# Uses Playwright + Browser-use to control the user's REAL Chrome session.

async def main():
    # 1. Configurar el modelo (Gemini 1.5 Pro)
    # Nota: Asegúrate de que la API KEY esté en el ambiente
    llm = ChatGoogleGenerativeAI(model="gemini-1.5-pro")

    # 2. Configurar el Browser para usar el puerto de depuración 9222
    # Esto permite usar las SESIONES REALES del usuario
    browser = Browser(
        config=BrowserConfig(
            chrome_instance_path=r'C:\Program Files\Google\Chrome\Application\chrome.exe',
        )
    )

    # 3. Misión: Switch de cuenta y apertura de Cloud Shell
    mission = (
        "1. Ve a https://console.cloud.google.com/ "
        "2. Si la cuenta activa no es israel.realivazquez2811@gmail.com, cambia a ella usando el menú de perfil. "
        "3. Una vez en la cuenta correcta, abre el Cloud Shell Editor. "
        "4. Confirma que la terminal está lista."
    )
    
    agent = Agent(task=mission, llm=llm, browser=browser)
    
    print("[*] Iniciando Agente de Navegación Nexus...")
    await agent.run()

if __name__ == '__main__':
    # Antes de correr, el usuario debe abrir Chrome con:
    # chrome.exe --remote-debugging-port=9222
    asyncio.run(main())
