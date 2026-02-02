# Guía de Inicio Rápido

Empieza en 5 minutos con tu setup completo de IA para desarrollo.

## Instalación en Un Comando

### Linux/macOS

```bash
git clone https://github.com/tu-usuario/improved-parakeet.git
cd improved-parakeet
chmod +x setup.sh
./setup.sh
```

### Windows

```powershell
git clone https://github.com/tu-usuario/improved-parakeet.git
cd improved-parakeet
.\setup.ps1
```

## Pasos Post-Instalación

### 1. Instalar Google Antigravity (5 min)

1. Visita: https://antigravity.dev/download
2. Descarga para tu SO
3. Instala y abre la aplicación
4. Inicia sesión con Google
5. Selecciona Gemini 3 Pro (gratis)

### 2. Iniciar Antigravity Proxy (1 min)

```bash
npx antigravity-claude-proxy@latest start
```

En tu navegador, abre: http://localhost:8080

- Haz clic en "Add Account"
- Autoriza con tu cuenta de Google

### 3. Usar Claude con Antigravity (1 min)

```bash
# Recarga tu shell primero
source ~/.bashrc  # o source ~/.zshrc en macOS

# Inicia Claude con Antigravity
claude-antigravity
```

### 4. Instalar Extensiones MCP (3 min)

**Chrome/Brave:**

1. Abre `chrome://extensions/` (o `brave://extensions/`)
2. Activa "Modo de desarrollador" (arriba a la derecha)
3. Clic en "Cargar extensión sin empaquetar"
4. Navega a:
   - `~/.mcp-extensions/chrome-devtools-mcp/dist`
   - Clic "Seleccionar"
5. Repite para:
   - `~/.mcp-extensions/claude-mcp/dist`

**Verificar:**
Las extensiones deben aparecer en la lista con íconos.

## Verificación

### Test 1: Claude CLI

```bash
claude doctor
```

Esperado: ✅ Todo verde

### Test 2: Claude con Antigravity

```bash
claude-antigravity
```

En la sesión de Claude:
```
Tú: Hola! ¿Qué modelo estás usando?

Claude: Estoy usando Claude Sonnet 4.5 a través de Antigravity...
```

### Test 3: MCP

En Claude CLI:
```bash
claude
```

Luego:
```
/mcp
```

Esperado: Lista de servidores MCP disponibles

### Test 4: Extensiones Chrome

1. Abre Chrome/Brave
2. Haz clic en el icono de extensiones (puzzle)
3. Debes ver las extensiones MCP instaladas

## Comandos Esenciales

```bash
# Claude normal (usa tu API key de Anthropic)
claude

# Claude con Antigravity (gratis)
claude-antigravity

# Ver servidores MCP
claude mcp list

# Agregar servidor MCP
claude mcp add --transport http nombre https://url

# Iniciar proxy de Antigravity
npx antigravity-claude-proxy@latest start

# Ver estado de Claude
claude doctor
```

## Workflows Comunes

### Desarrollo Web

```bash
claude-antigravity
```

```
Tú: Crea una página de login moderna con React y Tailwind

Claude:
✓ Estructura del componente
✓ Estilos Tailwind
✓ Validación de formulario
✓ Manejo de estado
✓ Tests

[Código generado]
```

### Code Review

```bash
claude-antigravity
```

```
Tú: Revisa este pull request: [pega link o código]

Claude:
Analizado 5 archivos. Encontré:
- 3 mejoras de rendimiento
- 1 potencial bug en auth.js:45
- 2 sugerencias de refactoring
```

### Debugging

```bash
claude
```

```
Tú: Tengo este error: [pega stack trace]

Claude:
El error es causado por...
Solución: [explicación + fix]
```

### Database Queries

```bash
# Primero configura MCP para database
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub

claude
```

```
Tú: ¿Cuántos usuarios registrados tenemos esta semana?

Claude: [ejecuta query vía MCP]
SELECT COUNT(*) FROM users WHERE created_at >= NOW() - INTERVAL '7 days';

Resultado: 234 usuarios
```

## Solución Rápida de Problemas

### Claude no encuentra el comando

```bash
# Agregar al PATH manualmente
export PATH="$HOME/.claude/bin:$PATH"

# Hacerlo permanente
echo 'export PATH="$HOME/.claude/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Proxy no conecta

```bash
# Verificar que está corriendo
curl http://localhost:8080/health

# Si no está corriendo, iniciarlo
npx antigravity-claude-proxy@latest start
```

### MCP Extensions no funcionan

1. Verifica "Modo de desarrollador" esté activado
2. Reconstruye la extensión:
   ```bash
   cd ~/.mcp-extensions/chrome-devtools-mcp
   npm run build
   ```
3. Recarga la extensión en `chrome://extensions/`

### Claude-antigravity no funciona

```bash
# Verificar variables de entorno
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_AUTH_TOKEN

# Si están vacías, recarga el shell
source ~/.bashrc  # o ~/.zshrc
```

## Próximos Pasos

1. **Lee la documentación completa**: [README.md](./README.md)
2. **Explora guías avanzadas**:
   - [Guía de Antigravity](./docs/ANTIGRAVITY_GUIDE.md)
   - [Guía de MCP](./docs/MCP_GUIDE.md)
3. **Configura MCP servers adicionales**: GitHub, Sentry, etc.
4. **Crea tus propios skills**
5. **Explora la comunidad**: [Antigravity Awesome Skills](https://github.com/sickn33/antigravity-awesome-skills)

## Recursos de Ayuda

- **Documentación**: Ver [`/docs`](./docs/)
- **Issues**: Reporta problemas en GitHub
- **Comunidad**:
  - [Antigravity Discord](https://discord.gg/antigravity)
  - [Claude Code Discussions](https://github.com/anthropics/claude-code/discussions)

## Cheatsheet

| Comando | Descripción |
|---------|-------------|
| `claude` | Inicia Claude CLI (API key) |
| `claude-antigravity` | Inicia Claude con Antigravity (gratis) |
| `claude doctor` | Verifica instalación |
| `claude mcp list` | Lista servidores MCP |
| `claude mcp add` | Agrega servidor MCP |
| `/mcp` | Ver MCP en sesión |
| `npx antigravity-claude-proxy@latest start` | Inicia proxy |

---

**¿Listo?** Ejecuta `./setup.sh` y empieza a desarrollar con IA! 🚀
