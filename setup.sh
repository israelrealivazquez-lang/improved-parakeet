#!/bin/bash

# Script de Instalación Completa
# Antigravity + Claude CLI + MCP + Codex
# Para Linux y macOS

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Banner
echo "================================================"
echo "  Configuración Completa: AI Development Setup"
echo "  Antigravity + Claude + MCP + Codex"
echo "================================================"
echo ""

# Verificar requisitos del sistema
print_info "Verificando requisitos del sistema..."

# Verificar Node.js
if ! command -v node &> /dev/null; then
    print_error "Node.js no está instalado. Por favor instala Node.js 18+ primero."
    echo "Visita: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js versión 18+ es requerida. Versión actual: $(node -v)"
    exit 1
fi
print_success "Node.js $(node -v) detectado"

# Verificar npm
if ! command -v npm &> /dev/null; then
    print_error "npm no está instalado."
    exit 1
fi
print_success "npm $(npm -v) detectado"

# Verificar Git
if ! command -v git &> /dev/null; then
    print_error "Git no está instalado. Por favor instala Git primero."
    exit 1
fi
print_success "Git $(git --version | cut -d' ' -f3) detectado"

echo ""

# Paso 1: Instalar Claude CLI
print_info "=== Paso 1/5: Instalando Claude CLI ==="
echo ""

if command -v claude &> /dev/null; then
    print_warning "Claude CLI ya está instalado ($(claude --version 2>/dev/null || echo 'versión desconocida'))"
    read -p "¿Reinstalar? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Reinstalando Claude CLI..."
        curl -fsSL https://claude.ai/install.sh | bash
    fi
else
    print_info "Instalando Claude CLI..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Agregar Claude al PATH si no está
if ! command -v claude &> /dev/null; then
    print_warning "Claude CLI no está en el PATH. Agregando a ~/.bashrc y ~/.zshrc"

    if [ -f "$HOME/.bashrc" ]; then
        echo 'export PATH="$HOME/.claude/bin:$PATH"' >> "$HOME/.bashrc"
    fi

    if [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/.claude/bin:$PATH"' >> "$HOME/.zshrc"
    fi

    export PATH="$HOME/.claude/bin:$PATH"
fi

if command -v claude &> /dev/null; then
    print_success "Claude CLI instalado correctamente"
else
    print_error "Error al instalar Claude CLI. Por favor, instala manualmente."
    exit 1
fi

echo ""

# Paso 2: Instalar Antigravity Claude Proxy
print_info "=== Paso 2/5: Instalando Antigravity Claude Proxy ==="
echo ""

print_info "Instalando antigravity-claude-proxy globalmente..."
npm install -g antigravity-claude-proxy

print_success "Antigravity Claude Proxy instalado"
print_warning "IMPORTANTE: Necesitarás iniciar el proxy manualmente con:"
echo "  npx antigravity-claude-proxy@latest start"
echo "  Luego autoriza tu cuenta de Google en http://localhost:8080"

echo ""

# Paso 3: Configurar alias para Claude + Antigravity
print_info "=== Paso 3/5: Configurando alias claude-antigravity ==="
echo ""

ALIAS_COMMAND='alias claude-antigravity='"'"'CLAUDE_CONFIG_DIR=~/.claude-antigravity ANTHROPIC_BASE_URL=http://localhost:8080/v1 ANTHROPIC_AUTH_TOKEN=antigravity-proxy claude'"'"

# Agregar a .bashrc
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "claude-antigravity" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Alias para Claude con Antigravity" >> "$HOME/.bashrc"
        echo "$ALIAS_COMMAND" >> "$HOME/.bashrc"
        print_success "Alias agregado a ~/.bashrc"
    else
        print_warning "Alias ya existe en ~/.bashrc"
    fi
fi

# Agregar a .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "claude-antigravity" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Alias para Claude con Antigravity" >> "$HOME/.zshrc"
        echo "$ALIAS_COMMAND" >> "$HOME/.zshrc"
        print_success "Alias agregado a ~/.zshrc"
    else
        print_warning "Alias ya existe en ~/.zshrc"
    fi
fi

echo ""

# Paso 4: Clonar extensiones MCP
print_info "=== Paso 4/5: Instalando extensiones MCP ==="
echo ""

MCP_DIR="$HOME/.mcp-extensions"
mkdir -p "$MCP_DIR"

# Chrome DevTools MCP
print_info "Clonando Chrome DevTools MCP..."
if [ -d "$MCP_DIR/chrome-devtools-mcp" ]; then
    print_warning "Chrome DevTools MCP ya existe. Actualizando..."
    cd "$MCP_DIR/chrome-devtools-mcp"
    git pull
else
    git clone https://github.com/ChromeDevTools/chrome-devtools-mcp.git "$MCP_DIR/chrome-devtools-mcp"
fi

cd "$MCP_DIR/chrome-devtools-mcp"
print_info "Instalando dependencias de Chrome DevTools MCP..."
npm install
print_info "Construyendo extensión..."
npm run build 2>/dev/null || print_warning "Build falló, puede que necesites construir manualmente"
print_success "Chrome DevTools MCP listo en: $MCP_DIR/chrome-devtools-mcp"

echo ""

# claude-mcp extension
print_info "Clonando claude-mcp extension..."
if [ -d "$MCP_DIR/claude-mcp" ]; then
    print_warning "claude-mcp ya existe. Actualizando..."
    cd "$MCP_DIR/claude-mcp"
    git pull
else
    git clone https://github.com/dnakov/claude-mcp.git "$MCP_DIR/claude-mcp"
fi

cd "$MCP_DIR/claude-mcp"
print_info "Instalando dependencias de claude-mcp..."
npm install
print_info "Construyendo extensión..."
npm run build 2>/dev/null || print_warning "Build falló, puede que necesites construir manualmente"
print_success "claude-mcp listo en: $MCP_DIR/claude-mcp"

echo ""

# Paso 5: Crear archivo de configuración MCP
print_info "=== Paso 5/5: Creando archivo de configuración MCP ==="
echo ""

MCP_CONFIG_FILE=".mcp.json"

if [ -f "$MCP_CONFIG_FILE" ]; then
    print_warning "El archivo .mcp.json ya existe. ¿Sobrescribir? (y/N): "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Saltando creación de .mcp.json"
    else
        cp "$MCP_CONFIG_FILE" "$MCP_CONFIG_FILE.backup"
        print_info "Backup creado: $MCP_CONFIG_FILE.backup"
        cat > "$MCP_CONFIG_FILE" << 'EOF'
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
EOF
        print_success "Archivo .mcp.json creado"
    fi
else
    cat > "$MCP_CONFIG_FILE" << 'EOF'
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
EOF
    print_success "Archivo .mcp.json creado"
fi

echo ""
echo "================================================"
print_success "¡Instalación completada!"
echo "================================================"
echo ""

# Instrucciones finales
print_info "Próximos pasos:"
echo ""
echo "1. Instalar Google Antigravity:"
echo "   Visita: https://antigravity.dev/download"
echo ""
echo "2. Iniciar Antigravity Claude Proxy:"
echo "   $ npx antigravity-claude-proxy@latest start"
echo "   Luego abre http://localhost:8080 y autoriza tu cuenta de Google"
echo ""
echo "3. Usar Claude con Antigravity:"
echo "   $ claude-antigravity"
echo "   (Asegúrate de recargar tu shell primero: source ~/.bashrc o source ~/.zshrc)"
echo ""
echo "4. Cargar extensiones MCP en Chrome/Brave:"
echo "   - Abre chrome://extensions/ (o brave://extensions/)"
echo "   - Activa 'Modo de desarrollador'"
echo "   - Clic en 'Cargar extensión sin empaquetar'"
echo "   - Selecciona: $MCP_DIR/chrome-devtools-mcp/dist"
echo "   - Repite para: $MCP_DIR/claude-mcp/dist"
echo ""
echo "5. Configurar MCP en Claude:"
echo "   $ claude"
echo "   Luego usa el comando: /mcp"
echo ""
echo "6. Para ChatGPT Codex:"
echo "   - VS Code: Instala la extensión 'OpenAI ChatGPT'"
echo "   - Web: https://chatgpt.com/codex/"
echo "   (Requiere suscripción ChatGPT Plus/Pro)"
echo ""

print_info "Para más información, consulta el README.md"
echo ""
print_success "¡Disfruta tu nuevo entorno de desarrollo con IA! 🚀"
