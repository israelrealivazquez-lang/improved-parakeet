#!/bin/bash

# Script para instalar extensiones MCP para Chrome/Brave

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

echo "================================================"
echo "  Setup: MCP Extensions para Chrome/Brave"
echo "================================================"
echo ""

MCP_DIR="$HOME/.mcp-extensions"
mkdir -p "$MCP_DIR"

# Chrome DevTools MCP
print_info "Instalando Chrome DevTools MCP..."

if [ -d "$MCP_DIR/chrome-devtools-mcp" ]; then
    print_warning "Ya existe. Actualizando..."
    cd "$MCP_DIR/chrome-devtools-mcp"
    git pull
else
    git clone https://github.com/ChromeDevTools/chrome-devtools-mcp.git "$MCP_DIR/chrome-devtools-mcp"
    cd "$MCP_DIR/chrome-devtools-mcp"
fi

npm install
npm run build
print_success "Chrome DevTools MCP listo"

# claude-mcp extension
print_info "Instalando claude-mcp extension..."

if [ -d "$MCP_DIR/claude-mcp" ]; then
    print_warning "Ya existe. Actualizando..."
    cd "$MCP_DIR/claude-mcp"
    git pull
else
    git clone https://github.com/dnakov/claude-mcp.git "$MCP_DIR/claude-mcp"
    cd "$MCP_DIR/claude-mcp"
fi

npm install
npm run build
print_success "claude-mcp listo"

echo ""
print_success "Extensiones MCP instaladas!"
echo ""
print_info "Para cargarlas en Chrome/Brave:"
echo "1. Abre chrome://extensions/ (o brave://extensions/)"
echo "2. Activa 'Modo de desarrollador'"
echo "3. Clic en 'Cargar extensión sin empaquetar'"
echo "4. Selecciona:"
echo "   - $MCP_DIR/chrome-devtools-mcp/dist"
echo "   - $MCP_DIR/claude-mcp/dist"
echo ""
