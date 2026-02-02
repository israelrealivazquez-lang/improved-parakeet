# Script de Instalación Completa para Windows
# Antigravity + Claude CLI + MCP + Codex
# PowerShell

# Requerir permisos de administrador para algunas operaciones
#Requires -Version 5.1

$ErrorActionPreference = "Stop"

# Colores para output
function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Banner
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Configuración Completa: AI Development Setup" -ForegroundColor Cyan
Write-Host "  Antigravity + Claude + MCP + Codex" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar requisitos del sistema
Write-Info "Verificando requisitos del sistema..."

# Verificar Node.js
try {
    $nodeVersion = node -v
    $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')

    if ($versionNumber -lt 18) {
        Write-Error "Node.js versión 18+ es requerida. Versión actual: $nodeVersion"
        Write-Host "Visita: https://nodejs.org/"
        exit 1
    }
    Write-Success "Node.js $nodeVersion detectado"
} catch {
    Write-Error "Node.js no está instalado. Por favor instala Node.js 18+ primero."
    Write-Host "Visita: https://nodejs.org/"
    exit 1
}

# Verificar npm
try {
    $npmVersion = npm -v
    Write-Success "npm $npmVersion detectado"
} catch {
    Write-Error "npm no está instalado."
    exit 1
}

# Verificar Git
try {
    $gitVersion = git --version
    Write-Success "$gitVersion detectado"
} catch {
    Write-Error "Git no está instalado. Por favor instala Git primero."
    Write-Host "Visita: https://git-scm.com/download/win"
    exit 1
}

Write-Host ""

# Paso 1: Instalar Claude CLI
Write-Info "=== Paso 1/5: Instalando Claude CLI ==="
Write-Host ""

try {
    $claudeExists = Get-Command claude -ErrorAction SilentlyContinue
    if ($claudeExists) {
        Write-Warning "Claude CLI ya está instalado"
        $response = Read-Host "¿Reinstalar? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Write-Info "Reinstalando Claude CLI..."
            Invoke-Expression (Invoke-RestMethod https://claude.ai/install.ps1)
        }
    } else {
        Write-Info "Instalando Claude CLI..."
        Invoke-Expression (Invoke-RestMethod https://claude.ai/install.ps1)
    }
    Write-Success "Claude CLI instalado correctamente"
} catch {
    Write-Error "Error al instalar Claude CLI: $_"
    exit 1
}

Write-Host ""

# Paso 2: Instalar Antigravity Claude Proxy
Write-Info "=== Paso 2/5: Instalando Antigravity Claude Proxy ==="
Write-Host ""

try {
    Write-Info "Instalando antigravity-claude-proxy globalmente..."
    npm install -g antigravity-claude-proxy
    Write-Success "Antigravity Claude Proxy instalado"
    Write-Warning "IMPORTANTE: Necesitarás iniciar el proxy manualmente con:"
    Write-Host "  npx antigravity-claude-proxy@latest start"
    Write-Host "  Luego autoriza tu cuenta de Google en http://localhost:8080"
} catch {
    Write-Error "Error al instalar antigravity-claude-proxy: $_"
}

Write-Host ""

# Paso 3: Configurar función para Claude + Antigravity
Write-Info "=== Paso 3/5: Configurando función claude-antigravity ==="
Write-Host ""

$profilePath = $PROFILE.CurrentUserAllHosts
if (-not $profilePath) {
    $profilePath = "$HOME\.config\powershell\profile.ps1"
}

# Crear directorio del perfil si no existe
$profileDir = Split-Path -Parent $profilePath
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Crear archivo de perfil si no existe
if (-not (Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$functionCode = @'

# Función para Claude con Antigravity
function claude-antigravity {
    $env:CLAUDE_CONFIG_DIR = "$HOME\.claude-antigravity"
    $env:ANTHROPIC_BASE_URL = "http://localhost:8080/v1"
    $env:ANTHROPIC_AUTH_TOKEN = "antigravity-proxy"
    claude
}
'@

$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

if (-not $profileContent -or $profileContent -notlike "*claude-antigravity*") {
    Add-Content -Path $profilePath -Value $functionCode
    Write-Success "Función agregada a $profilePath"
} else {
    Write-Warning "Función ya existe en $profilePath"
}

Write-Host ""

# Paso 4: Clonar extensiones MCP
Write-Info "=== Paso 4/5: Instalando extensiones MCP ==="
Write-Host ""

$mcpDir = "$HOME\.mcp-extensions"
if (-not (Test-Path $mcpDir)) {
    New-Item -ItemType Directory -Path $mcpDir -Force | Out-Null
}

# Chrome DevTools MCP
Write-Info "Clonando Chrome DevTools MCP..."
$chromeDevToolsPath = "$mcpDir\chrome-devtools-mcp"

if (Test-Path $chromeDevToolsPath) {
    Write-Warning "Chrome DevTools MCP ya existe. Actualizando..."
    Set-Location $chromeDevToolsPath
    git pull
} else {
    git clone https://github.com/ChromeDevTools/chrome-devtools-mcp.git $chromeDevToolsPath
}

Set-Location $chromeDevToolsPath
Write-Info "Instalando dependencias de Chrome DevTools MCP..."
npm install

Write-Info "Construyendo extensión..."
try {
    npm run build
    Write-Success "Chrome DevTools MCP listo en: $chromeDevToolsPath"
} catch {
    Write-Warning "Build falló, puede que necesites construir manualmente"
}

Write-Host ""

# claude-mcp extension
Write-Info "Clonando claude-mcp extension..."
$claudeMcpPath = "$mcpDir\claude-mcp"

if (Test-Path $claudeMcpPath) {
    Write-Warning "claude-mcp ya existe. Actualizando..."
    Set-Location $claudeMcpPath
    git pull
} else {
    git clone https://github.com/dnakov/claude-mcp.git $claudeMcpPath
}

Set-Location $claudeMcpPath
Write-Info "Instalando dependencias de claude-mcp..."
npm install

Write-Info "Construyendo extensión..."
try {
    npm run build
    Write-Success "claude-mcp listo en: $claudeMcpPath"
} catch {
    Write-Warning "Build falló, puede que necesites construir manualmente"
}

Write-Host ""

# Volver al directorio original
Set-Location $PSScriptRoot

# Paso 5: Crear archivo de configuración MCP
Write-Info "=== Paso 5/5: Creando archivo de configuración MCP ==="
Write-Host ""

$mcpConfigFile = ".mcp.json"

if (Test-Path $mcpConfigFile) {
    Write-Warning "El archivo .mcp.json ya existe."
    $response = Read-Host "¿Sobrescribir? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Copy-Item $mcpConfigFile "$mcpConfigFile.backup"
        Write-Info "Backup creado: $mcpConfigFile.backup"
    } else {
        Write-Info "Saltando creación de .mcp.json"
        $mcpConfigFile = $null
    }
}

if ($mcpConfigFile) {
    $mcpConfig = @'
{
  "mcpServers": {
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": ["chrome-devtools-mcp"]
    },
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/"
    }
  }
}
'@

    Set-Content -Path $mcpConfigFile -Value $mcpConfig
    Write-Success "Archivo .mcp.json creado"
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Success "¡Instalación completada!"
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Instrucciones finales
Write-Info "Próximos pasos:"
Write-Host ""
Write-Host "1. Instalar Google Antigravity:"
Write-Host "   Visita: https://antigravity.dev/download"
Write-Host ""
Write-Host "2. Iniciar Antigravity Claude Proxy:"
Write-Host "   PS> npx antigravity-claude-proxy@latest start"
Write-Host "   Luego abre http://localhost:8080 y autoriza tu cuenta de Google"
Write-Host ""
Write-Host "3. Usar Claude con Antigravity:"
Write-Host "   PS> claude-antigravity"
Write-Host "   (Asegúrate de recargar tu perfil primero: . `$PROFILE)"
Write-Host ""
Write-Host "4. Cargar extensiones MCP en Chrome/Brave:"
Write-Host "   - Abre chrome://extensions/ (o brave://extensions/)"
Write-Host "   - Activa 'Modo de desarrollador'"
Write-Host "   - Clic en 'Cargar extensión sin empaquetar'"
Write-Host "   - Selecciona: $chromeDevToolsPath\dist"
Write-Host "   - Repite para: $claudeMcpPath\dist"
Write-Host ""
Write-Host "5. Configurar MCP en Claude:"
Write-Host "   PS> claude"
Write-Host "   Luego usa el comando: /mcp"
Write-Host ""
Write-Host "6. Para ChatGPT Codex:"
Write-Host "   - VS Code: Instala la extensión 'OpenAI ChatGPT'"
Write-Host "   - Web: https://chatgpt.com/codex/"
Write-Host "   (Requiere suscripción ChatGPT Plus/Pro)"
Write-Host ""

Write-Info "Para más información, consulta el README.md"
Write-Host ""
Write-Success "¡Disfruta tu nuevo entorno de desarrollo con IA! 🚀"
