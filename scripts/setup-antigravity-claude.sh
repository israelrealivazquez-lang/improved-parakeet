#!/bin/bash

# Script para configurar la integración de Antigravity con Claude CLI

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
echo "  Setup: Antigravity + Claude CLI Integration"
echo "================================================"
echo ""

# Verificar Claude CLI
if ! command -v claude &> /dev/null; then
    print_error "Claude CLI no está instalado."
    print_info "Instalando Claude CLI..."
    curl -fsSL https://claude.ai/install.sh | bash
    export PATH="$HOME/.claude/bin:$PATH"
fi

print_success "Claude CLI detectado"

# Instalar antigravity-claude-proxy
print_info "Instalando antigravity-claude-proxy..."
npm install -g antigravity-claude-proxy

print_success "Antigravity Claude Proxy instalado"

# Configurar alias
print_info "Configurando alias claude-antigravity..."

ALIAS_COMMAND='alias claude-antigravity='"'"'CLAUDE_CONFIG_DIR=~/.claude-antigravity ANTHROPIC_BASE_URL=http://localhost:8080/v1 ANTHROPIC_AUTH_TOKEN=antigravity-proxy claude'"'"

if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "claude-antigravity" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Alias para Claude con Antigravity" >> "$HOME/.bashrc"
        echo "$ALIAS_COMMAND" >> "$HOME/.bashrc"
        print_success "Alias agregado a ~/.bashrc"
    fi
fi

if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "claude-antigravity" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Alias para Claude con Antigravity" >> "$HOME/.zshrc"
        echo "$ALIAS_COMMAND" >> "$HOME/.zshrc"
        print_success "Alias agregado a ~/.zshrc"
    fi
fi

echo ""
print_success "Configuración completada!"
echo ""
print_info "Próximos pasos:"
echo "1. Inicia el proxy: npx antigravity-claude-proxy@latest start"
echo "2. Autoriza tu cuenta en: http://localhost:8080"
echo "3. Recarga tu shell: source ~/.bashrc (o ~/.zshrc)"
echo "4. Usa: claude-antigravity"
echo ""
