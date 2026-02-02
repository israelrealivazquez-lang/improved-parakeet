# 🚀 Configuración Completa: Antigravity + Claude + MCP + Codex

Guía completa para configurar un entorno de desarrollo avanzado con IA, integrando Google Antigravity, Claude Code CLI, Model Context Protocol (MCP), y ChatGPT Codex.

## 📋 Tabla de Contenidos

- [Descripción General](#-descripción-general)
- [Requisitos del Sistema](#-requisitos-del-sistema)
- [Instalación de Google Antigravity](#-instalación-de-google-antigravity)
- [Configuración de Claude CLI](#-configuración-de-claude-cli)
- [Integración Antigravity + Claude](#-integración-antigravity--claude)
- [MCP para Chrome y Brave](#-mcp-para-chrome-y-brave)
- [Configuración de Cowork](#-configuración-de-cowork)
- [ChatGPT Codex](#-chatgpt-codex)
- [Scripts de Configuración](#-scripts-de-configuración)
- [Solución de Problemas](#-solución-de-problemas)

## 🌟 Descripción General

Este proyecto te ayuda a configurar:

- **Google Antigravity**: IDE con IA de Google (gratis en preview público)
- **Claude Code CLI**: Interfaz de línea de comandos oficial de Anthropic
- **MCP (Model Context Protocol)**: Protocolo para conectar Claude con herramientas externas
- **Extensiones de Chrome/Brave**: Para integración de IA en el navegador
- **ChatGPT Codex**: Asistente de código de OpenAI
- **Integración completa**: Claude local conectado con Antigravity

## 💻 Requisitos del Sistema

### Mínimos
- **SO**: Windows 10+, macOS Monterey (12)+, o Linux
- **RAM**: 8GB (16GB recomendado para Apple Silicon)
- **Espacio en disco**: 2GB
- **Conexión a Internet**: Necesaria para instalación y uso inicial

### Recomendados (para mejor rendimiento)
- **macOS**: Apple Silicon (M1/M2/M3/M4) - optimizado para inferencia local
- **RAM**: 16GB+ para ejecutar modelos locales
- **SSD**: Para mejor velocidad de carga

### Software Necesario
- Node.js 18+ y npm
- Git
- Chrome o Brave Browser
- Terminal (bash, zsh, PowerShell)

## 🔧 Instalación de Google Antigravity

### Paso 1: Descargar Antigravity

Visita el sitio oficial y descarga la versión para tu sistema operativo:

```bash
# macOS (Homebrew - cuando esté disponible)
brew install --cask google-antigravity

# O descarga directamente desde:
# https://antigravity.dev/download
```

Para más información, consulta:
- [Getting Started with Google Antigravity](https://codelabs.developers.google.com/getting-started-google-antigravity)
- [Build with Google Antigravity](https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/)

### Paso 2: Primer Inicio

1. Abre Antigravity
2. Inicia sesión con tu cuenta de Google
3. Acepta los términos de servicio
4. Selecciona tus preferencias de modelo (Gemini 3 Pro es gratuito)

### Paso 3: Verificar Instalación

En la terminal de Antigravity:

```bash
# Verificar que Antigravity está funcionando
echo "Hola Antigravity"
```

## 🤖 Configuración de Claude CLI

### Instalación

Elige el método según tu sistema operativo:

**Linux/macOS/WSL:**
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://claude.ai/install.ps1 | iex
```

**macOS (Homebrew):**
```bash
brew install --cask claude-code
```

**Windows (WinGet):**
```powershell
winget install Anthropic.ClaudeCode
```

### Verificar Instalación

```bash
claude doctor
```

### Configuración Inicial

```bash
# Navega a tu proyecto
cd /ruta/a/tu/proyecto

# Inicia Claude
claude

# Crear archivo de configuración del proyecto
claude init
```

## 🔗 Integración Antigravity + Claude

Esta es la parte más importante: conectar Claude CLI con los modelos gratuitos de Antigravity.

### Método 1: Usando antigravity-claude-proxy (Recomendado)

1. **Instalar el proxy:**

```bash
npm install -g antigravity-claude-proxy
```

2. **Iniciar el proxy:**

```bash
npx antigravity-claude-proxy@latest start
```

3. **Autorizar tu cuenta de Google:**

- Abre http://localhost:8080 en tu navegador
- Ve a la pestaña "Accounts"
- Haz clic en "Add Account"
- Completa la autorización OAuth de Google

4. **Configurar Claude CLI para usar el proxy:**

```bash
# Configurar variables de entorno
export ANTHROPIC_BASE_URL="http://localhost:8080/v1"
export ANTHROPIC_AUTH_TOKEN="antigravity-proxy"

# Iniciar Claude
claude
```

5. **Crear alias para uso permanente (opcional):**

**Linux/macOS (~/.bashrc o ~/.zshrc):**
```bash
alias claude-antigravity='CLAUDE_CONFIG_DIR=~/.claude-antigravity ANTHROPIC_BASE_URL=http://localhost:8080/v1 ANTHROPIC_AUTH_TOKEN=antigravity-proxy claude'
```

**Windows PowerShell (~/.config/powershell/profile.ps1):**
```powershell
function claude-antigravity {
    $env:CLAUDE_CONFIG_DIR = "$HOME\.claude-antigravity"
    $env:ANTHROPIC_BASE_URL = "http://localhost:8080/v1"
    $env:ANTHROPIC_AUTH_TOKEN = "antigravity-proxy"
    claude
}
```

### Recursos de Integración

Para más detalles, consulta:
- [Claude Code CLI Integration](https://deepwiki.com/lbjlaq/Antigravity-Manager/5.1-claude-code-cli-integration)
- [antigravity-claude-proxy GitHub](https://github.com/badrisnarayanan/antigravity-claude-proxy)
- [How to Use Free Antigravity AI Models in Claude Code](https://syntackle.com/blog/claude-code-free-using-antigravity-proxy/)

## 🌐 MCP para Chrome y Brave

Model Context Protocol permite que Claude interactúe con tu navegador.

### Extensiones Disponibles

#### 1. Chrome DevTools MCP (Oficial de Google)

Control completo de Chrome DevTools para agentes de IA.

**Instalación:**
```bash
# Clonar el repositorio
git clone https://github.com/ChromeDevTools/chrome-devtools-mcp.git
cd chrome-devtools-mcp

# Instalar dependencias
npm install

# Construir la extensión
npm run build
```

**Cargar en Chrome/Brave:**
1. Abre Chrome/Brave
2. Ve a `chrome://extensions/`
3. Activa "Modo de desarrollador"
4. Haz clic en "Cargar extensión sin empaquetar"
5. Selecciona la carpeta `chrome-devtools-mcp/dist`

**Configurar en Claude:**
```bash
claude mcp add --transport stdio chrome-devtools -- npx chrome-devtools-mcp
```

#### 2. Browser MCP

Automatiza tareas en el navegador con Claude.

**Instalación:**
- [Browser MCP en Chrome Web Store](https://chromewebstore.google.com/detail/browser-mcp-automate-your/bjfgambnhccakkhmkepdoekmckoijdlc)

**Configuración:**
1. Instala la extensión desde Chrome Web Store
2. Haz clic en el icono de la extensión
3. Copia el comando de configuración
4. Ejecuta en tu terminal:

```bash
claude mcp add --transport http browser-mcp https://localhost:3000/mcp
```

#### 3. claude-mcp (Habilitar MCP en claude.ai)

**Instalación:**
```bash
# Clonar repositorio
git clone https://github.com/dnakov/claude-mcp.git
cd claude-mcp

# Instalar y construir
npm install
npm run build
```

**Cargar extensión:**
1. Ve a `chrome://extensions/` o `brave://extensions/`
2. Activa "Modo de desarrollador"
3. "Cargar extensión sin empaquetar" → selecciona carpeta `dist`

#### 4. Web to MCP

Convierte componentes de sitios web en código para Claude/Cursor.

**Instalación:**
- [Web to MCP en Chrome Web Store](https://chromewebstore.google.com/detail/web-to-mcp-import-any-web/hbnhkfkblpgjlfonnikijlofeiabolmi)

### Configuración en Brave

Las mismas extensiones funcionan en Brave:

1. Abre `brave://extensions/`
2. Activa "Modo de desarrollador"
3. Sigue los mismos pasos que para Chrome

### Recursos de MCP

- [GitHub hangwin/mcp-chrome](https://github.com/hangwin/mcp-chrome)
- [Chrome DevTools MCP GitHub](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [MCP Apps Blog](http://blog.modelcontextprotocol.io/posts/2026-01-26-mcp-apps/)

## 🤝 Configuración de Cowork

Cowork permite colaboración en tiempo real con IA en tu navegador.

### Requisitos Previos

1. Tener MCP configurado en Chrome/Brave
2. Claude CLI instalado
3. Antigravity funcionando

### Configuración

1. **Instalar Cowork MCP Server:**

```bash
# Si existe un paquete npm oficial (verifica disponibilidad)
npm install -g @cowork/mcp-server

# O usar servidor custom
claude mcp add --transport http cowork https://api.cowork.dev/mcp \
  --header "Authorization: Bearer TU_TOKEN_DE_COWORK"
```

2. **Configurar en `.mcp.json`:**

```json
{
  "mcpServers": {
    "cowork": {
      "type": "http",
      "url": "https://api.cowork.dev/mcp",
      "headers": {
        "Authorization": "Bearer ${COWORK_API_KEY}"
      }
    }
  }
}
```

3. **Variables de entorno:**

```bash
# Agregar a ~/.bashrc, ~/.zshrc, o perfil de PowerShell
export COWORK_API_KEY="tu-clave-api-aqui"
```

### Uso con Chrome/Brave

1. Abre la extensión de Cowork en tu navegador
2. Conéctate con tu cuenta
3. En Claude Code, usa `/mcp` para ver herramientas disponibles
4. Cowork aparecerá en la lista de herramientas activas

## 🧠 ChatGPT Codex

ChatGPT Codex es el asistente de código de OpenAI.

### Acceso a Codex

Codex está disponible para usuarios de ChatGPT Plus, Pro, Business, Edu y Enterprise.

### Métodos de Uso

#### 1. Extensión de VS Code

**Instalación:**
1. Abre VS Code
2. Ve a la pestaña de Extensiones (Ctrl+Shift+X)
3. Busca "Codex" o "OpenAI ChatGPT"
4. Instala la extensión oficial de OpenAI
5. Autentícate con tu cuenta de OpenAI

**Uso:**
- Presiona `Ctrl+Shift+P` → "Codex: Start Chat"
- O usa el panel lateral de Codex

#### 2. Web Interface

**Acceso directo:**
```
https://chatgpt.com/codex/
```

1. Inicia sesión con tu cuenta de ChatGPT
2. Selecciona un proyecto o crea uno nuevo
3. Chatea con Codex para asistencia de código

#### 3. CLI de Codex

**Instalación (si está disponible):**
```bash
npm install -g @openai/codex-cli
```

**Uso:**
```bash
codex login
codex chat
```

#### 4. Integración con GitHub

Puedes usar Codex en Pull Requests:

1. Ve a un PR en GitHub
2. Comenta mencionando `@codex`
3. Codex analizará el código y sugerirá mejoras

### Integración con Antigravity

Actualmente, Codex funciona de manera independiente, pero puedes usar ambos:

1. Antigravity para desarrollo general con Gemini/Claude
2. Codex para tareas específicas de OpenAI/GPT

### Recursos de Codex

- [Codex Official Page](https://chatgpt.com/features/codex/)
- [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=openai.chatgpt)
- [Using Codex with ChatGPT](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)
- [Codex Developer Docs](https://developers.openai.com/codex/)

## ⚙️ Scripts de Configuración

Para automatizar todo el proceso, usa los scripts incluidos en este repositorio.

### Script de Instalación Completa

**Linux/macOS:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows:**
```powershell
.\setup.ps1
```

### Script Individual: Antigravity + Claude

```bash
./scripts/setup-antigravity-claude.sh
```

### Script Individual: MCP Extensions

```bash
./scripts/setup-mcp-extensions.sh
```

Ver la carpeta [`/scripts`](./scripts/) para todos los scripts disponibles.

## 🐛 Solución de Problemas

### Antigravity no inicia

**Problema:** Error al iniciar Antigravity
**Solución:**
```bash
# Verificar requisitos del sistema
# macOS: Asegúrate de tener Monterey (12)+
# Reinstalar:
rm -rf ~/Applications/Antigravity.app
# Descarga nuevamente desde antigravity.dev
```

### Claude CLI no conecta con Antigravity

**Problema:** Error de autenticación
**Solución:**
```bash
# Verificar que el proxy esté corriendo
curl http://localhost:8080/health

# Reiniciar el proxy
pkill -f antigravity-claude-proxy
npx antigravity-claude-proxy@latest start

# Reautorizar en http://localhost:8080
```

### MCP Extensions no cargan

**Problema:** Extensiones no aparecen en Chrome/Brave
**Solución:**
1. Verifica que el "Modo de desarrollador" esté activado
2. Reconstruye la extensión: `npm run build`
3. Recarga la extensión en `chrome://extensions/`
4. Revisa la consola de desarrollador (F12) para errores

### Codex no funciona

**Problema:** No tienes acceso a Codex
**Solución:**
- Codex requiere una suscripción de ChatGPT Plus/Pro/Business/Edu/Enterprise
- Verifica tu suscripción en https://platform.openai.com/account/billing
- Asegúrate de estar usando la cuenta correcta

## 📚 Recursos Adicionales

### Documentación Oficial

- [Google Antigravity Documentation](https://antigravityai.org/)
- [Claude Code CLI Docs](https://code.claude.com/docs)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [OpenAI Codex Documentation](https://openai.com/codex/)

### Tutoriales y Guías

- [Google Antigravity: The 2026 Guide](https://www.aifire.co/p/google-antigravity-the-2026-guide-to-the-best-ai-ide)
- [I Tried Claude Code In Google Antigravity](https://medium.com/@joe.njenga/i-tried-claude-code-in-google-antigravity-and-discovered-a-new-insane-workflow-e5402d043aa4)
- [How to Set Up and Use Google Antigravity - Codecademy](https://www.codecademy.com/article/how-to-set-up-and-use-google-antigravity)

### Comunidad

- [Antigravity Awesome Skills (600+ skills)](https://github.com/sickn33/antigravity-awesome-skills)
- [Antigravity Manager](https://deepwiki.com/lbjlaq/Antigravity-Manager/5-integration-examples)

## 🎨 Logo y Recursos Visuales

Ver la carpeta [`/assets`](./assets/) para logos y recursos visuales (modo claro y oscuro).

## 🤝 Contribuir

Si encuentras mejoras o tienes sugerencias:

1. Haz fork del repositorio
2. Crea una rama: `git checkout -b feature/mejora`
3. Commit tus cambios: `git commit -am 'Agrega mejora'`
4. Push a la rama: `git push origin feature/mejora`
5. Abre un Pull Request

## 📄 Licencia

Ver [LICENSE](LICENSE) para más detalles.

## ⭐ Agradecimientos

- Equipo de Google Antigravity
- Anthropic (Claude)
- OpenAI (Codex)
- Comunidad de desarrolladores de MCP

---

**¿Necesitas ayuda?** Abre un [issue](../../issues) o consulta la documentación vinculada arriba.

**¿Te fue útil?** Dale una ⭐ al repositorio!
