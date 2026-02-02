# Guía Completa de Model Context Protocol (MCP)

## ¿Qué es MCP?

Model Context Protocol (MCP) es un protocolo estándar abierto que permite que los modelos de IA (como Claude) se conecten con herramientas y servicios externos. Fue introducido por Anthropic y adoptado por Google, GitHub, y otras compañías.

## Conceptos Fundamentales

### 1. MCP Servers

Un MCP Server es un servicio que expone herramientas o recursos a un cliente de IA:

```
┌─────────────┐         MCP         ┌─────────────┐
│   Claude    │ ◄──────────────────► │  GitHub API │
│  (Cliente)  │                      │  (Servidor) │
└─────────────┘                      └─────────────┘
```

### 2. Tipos de Transporte

MCP soporta tres tipos de conexión:

#### HTTP
```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

Ventajas:
- ✅ Más simple
- ✅ Funciona con servicios remotos
- ✅ Soporta autenticación OAuth

#### SSE (Server-Sent Events)
```bash
claude mcp add --transport sse asana https://mcp.asana.com/sse
```

Ventajas:
- ✅ Streaming en tiempo real
- ✅ Conexión persistente

Nota: SSE está deprecated, usa HTTP cuando sea posible.

#### Stdio (Standard Input/Output)
```bash
claude mcp add --transport stdio database -- npx @bytebase/dbhub
```

Ventajas:
- ✅ Servidores locales
- ✅ Sin necesidad de red
- ✅ Más rápido

### 3. Tools, Resources, y Prompts

Un MCP Server puede exponer:

- **Tools**: Funciones que Claude puede ejecutar
  - Ejemplo: `github.create_issue()`

- **Resources**: Datos que Claude puede leer
  - Ejemplo: `file:///project/README.md`

- **Prompts**: Plantillas predefinidas
  - Ejemplo: `code_review_template`

## Configuración

### Archivo .mcp.json

Crea `.mcp.json` en la raíz de tu proyecto:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "description": "Integración con GitHub"
    },
    "database": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@bytebase/dbhub"],
      "env": {
        "DSN": "${DATABASE_URL}"
      },
      "description": "Consultas a PostgreSQL"
    },
    "sentry": {
      "type": "http",
      "url": "https://mcp.sentry.dev/mcp",
      "description": "Monitoreo de errores"
    }
  }
}
```

### Variables de Entorno

Usa `${VAR_NAME}` para variables de entorno:

```json
{
  "mcpServers": {
    "api": {
      "type": "http",
      "url": "${API_BASE_URL}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_TOKEN}"
      }
    }
  }
}
```

Con fallback:
```json
{
  "url": "${API_URL:-https://api.example.com}"
}
```

### Scopes (Alcances)

MCP servers pueden configurarse en tres niveles:

```
User     (~/.claude.json)         - Personal, todos los proyectos
  ↓
Project  (.mcp.json)              - Compartido en git
  ↓
Local    (.claude/settings.json)  - Local, no compartido
```

Ejemplo:
```bash
# User scope (disponible en todos tus proyectos)
claude mcp add --scope user --transport http github https://api.githubcopilot.com/mcp/

# Project scope (compartido con el equipo)
claude mcp add --scope project --transport stdio db -- npx @bytebase/dbhub

# Local scope (credenciales personales)
claude mcp add --scope local --transport http api https://api.example.com \
  --header "Authorization: Bearer tu-token-personal"
```

## MCP Servers Populares

### 1. GitHub

```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

**Herramientas disponibles**:
- Crear/listar issues
- Crear/revisar PRs
- Buscar código
- Gestionar branches

**Uso**:
```
Tú: Crea un issue para el bug de autenticación

Claude: [Usa github.create_issue()]
✓ Issue #123 creado
```

### 2. Sentry

```bash
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

**Herramientas disponibles**:
- Listar errores recientes
- Ver detalles de error
- Resolver/ignorar errores
- Ver stack traces

**Uso**:
```
Tú: ¿Cuáles son los errores más frecuentes esta semana?

Claude: [Usa sentry.list_issues()]
Los 3 errores más frecuentes son:
1. TypeError en auth.js (234 ocurrencias)
2. NetworkError en api.js (89 ocurrencias)
3. ValidationError en form.js (56 ocurrencias)
```

### 3. PostgreSQL (Bytebase DBHub)

```bash
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
  --dsn "postgresql://user:pass@localhost:5432/mydb"
```

**Herramientas disponibles**:
- Ejecutar queries SELECT
- Ver schema
- Listar tablas
- Describir columnas

**Uso**:
```
Tú: ¿Cuántos usuarios activos tenemos?

Claude: [Usa db.query()]
SELECT COUNT(*) FROM users WHERE active = true;

Resultado: 1,247 usuarios activos
```

### 4. Notion

```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
```

**Herramientas disponibles**:
- Buscar páginas
- Crear/actualizar páginas
- Listar databases
- Agregar bloques

### 5. Stripe

```bash
claude mcp add --transport http stripe https://mcp.stripe.com/mcp \
  --header "Authorization: Bearer ${STRIPE_SECRET_KEY}"
```

**Herramientas disponibles**:
- Listar pagos
- Crear/cancelar subscripciones
- Ver información de clientes
- Generar reportes

## Uso en Claude CLI

### Listar Servidores

```bash
claude mcp list
```

Output:
```
MCP Servers configurados:
  github      (http)  - https://api.githubcopilot.com/mcp/
  sentry      (http)  - https://mcp.sentry.dev/mcp
  database    (stdio) - npx @bytebase/dbhub
```

### Ver Detalles

```bash
claude mcp get github
```

### Eliminar Servidor

```bash
claude mcp remove github
```

### En la Sesión de Claude

Dentro de una sesión de Claude:

```bash
claude
```

Luego:
```
/mcp
```

Esto muestra todas las herramientas MCP disponibles y te permite autenticarte si es necesario.

## Extensiones MCP para Navegadores

### Chrome DevTools MCP

Control completo de Chrome para agentes de IA.

**Instalación**: Ver [README.md](../README.md#mcp-para-chrome-y-brave)

**Capacidades**:
- Inspeccionar elementos
- Ejecutar JavaScript
- Capturar screenshots
- Monitorear network
- Debuggear código

**Uso**:
```
Tú: Abre https://example.com y captura un screenshot

Claude: [Usa chrome.navigate() y chrome.screenshot()]
✓ Navegado a https://example.com
✓ Screenshot guardado en: screenshot.png
```

### Browser MCP

Automatización de navegador.

**Instalación**: [Chrome Web Store](https://chromewebstore.google.com/detail/browser-mcp-automate-your/bjfgambnhccakkhmkepdoekmckoijdlc)

**Capacidades**:
- Click en elementos
- Llenar formularios
- Scroll
- Esperar elementos

### Web to MCP

Convierte componentes web en código.

**Instalación**: [Chrome Web Store](https://chromewebstore.google.com/detail/web-to-mcp-import-any-web/hbnhkfkblpgjlfonnikijlofeiabolmi)

**Uso**:
1. Navega a un sitio web
2. Activa la extensión
3. Selecciona un componente
4. La extensión genera código + prompt
5. Envía a Claude Code vía MCP

## Crear tu Propio MCP Server

### Ejemplo Básico (Node.js)

```javascript
// mcp-server.js
import { McpServer } from '@modelcontextprotocol/sdk';

const server = new McpServer({
  name: 'my-custom-server',
  version: '1.0.0',
});

// Registrar una herramienta
server.tool({
  name: 'get_weather',
  description: 'Obtiene el clima de una ciudad',
  parameters: {
    city: {
      type: 'string',
      description: 'Nombre de la ciudad',
      required: true,
    },
  },
  async execute({ city }) {
    // Lógica para obtener el clima
    const weather = await fetchWeather(city);
    return {
      temperature: weather.temp,
      condition: weather.condition,
    };
  },
});

// Iniciar servidor HTTP
server.listen(3000);
```

### Conectar tu Servidor

```bash
claude mcp add --transport http my-weather http://localhost:3000
```

### SDK Oficial

```bash
npm install @modelcontextprotocol/sdk
```

Documentación: https://modelcontextprotocol.io/docs/sdk

## MCP Apps

MCP Apps es una extensión reciente que permite UIs interactivas.

### ¿Qué son?

En lugar de solo texto, los MCP Apps pueden retornar:
- Dashboards
- Formularios
- Visualizaciones
- Workflows multi-paso

### Ejemplo

```javascript
server.tool({
  name: 'show_analytics_dashboard',
  description: 'Muestra dashboard de analytics',
  async execute() {
    return {
      type: 'ui',
      component: 'Dashboard',
      props: {
        charts: [...],
        metrics: [...],
      },
    };
  },
});
```

Claude renderizará el dashboard directamente en la conversación.

## Configuración Avanzada

### Timeout

```bash
# Timeout de 10 segundos para herramientas MCP
MCP_TIMEOUT=10000 claude
```

### Límite de Output

```bash
# Aumentar tokens de salida de MCP
MAX_MCP_OUTPUT_TOKENS=50000 claude
```

### Búsqueda de Herramientas

Cuando tienes muchos MCP servers, Claude automáticamente activa búsqueda:

```bash
# Auto-activar si hay más del 5% de herramientas MCP
ENABLE_TOOL_SEARCH=auto:5 claude

# Siempre activar
ENABLE_TOOL_SEARCH=true claude

# Desactivar
ENABLE_TOOL_SEARCH=false claude
```

### Habilitar/Deshabilitar Servers

En `.claude/settings.json`:

```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": ["github", "sentry"],
  "disabledMcpjsonServers": ["database"]
}
```

## Autenticación OAuth 2.0

Algunos MCP servers requieren OAuth:

1. Agrega el servidor:
```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

2. En Claude, usa `/mcp`

3. Claude te dará un link para autorizar

4. Completa la autorización en el navegador

5. Claude almacena el token de forma segura

## Mejores Prácticas

### 1. Usa Scopes Apropiados

```
User     → Herramientas generales (GitHub, Sentry)
Project  → Específicas del proyecto (Database, APIs)
Local    → Con credenciales personales
```

### 2. Variables de Entorno

Nunca hardcodees credenciales:

❌ **Malo**:
```json
{
  "headers": {
    "Authorization": "Bearer sk_live_abc123xyz"
  }
}
```

✅ **Bueno**:
```json
{
  "headers": {
    "Authorization": "Bearer ${STRIPE_SECRET_KEY}"
  }
}
```

### 3. Descripción Clara

```json
{
  "mcpServers": {
    "db": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@bytebase/dbhub"],
      "description": "PostgreSQL production database (read-only)"
    }
  }
}
```

### 4. Agrupa Servers Relacionados

```
.mcp.json              # Servers del proyecto
.mcp.local.json        # Overrides locales (git-ignored)
```

## Troubleshooting

### Server no conecta

```bash
# Ver logs de MCP
DEBUG=mcp:* claude

# Verificar que el servidor está corriendo (HTTP)
curl http://localhost:3000/health

# Verificar comando (Stdio)
npx @bytebase/dbhub --help
```

### Timeout

```bash
# Aumentar timeout
MCP_TIMEOUT=30000 claude
```

### Herramientas no aparecen

1. Verifica el servidor esté en `.mcp.json`
2. Usa `/mcp` en Claude para ver servers activos
3. Revisa `enabledMcpjsonServers` en settings
4. Reinicia Claude

### Error de autenticación

1. Elimina y re-agrega el servidor
2. Limpia tokens: `rm ~/.claude/mcp-tokens.json`
3. Re-autentica con `/mcp`

## Recursos

### Documentación

- [MCP Specification](https://modelcontextprotocol.io/)
- [MCP SDK](https://modelcontextprotocol.io/docs/sdk)
- [Claude MCP Docs](https://code.claude.com/docs/en/mcp.md)

### Comunidad

- [MCP GitHub](https://github.com/modelcontextprotocol)
- [Awesome MCP](https://github.com/wong2/awesome-mcp)
- [MCP Discord](https://discord.gg/mcp)

### Ejemplos

- [MCP Servers Collection](https://github.com/modelcontextprotocol/servers)
- [Community MCP Servers](https://github.com/topics/mcp-server)

## Conclusión

MCP transforma Claude (y otros LLMs) en un verdadero agente que puede interactuar con cualquier herramienta o servicio. Dominar MCP es clave para aprovechar al máximo las capacidades de los asistentes de IA modernos.

Empieza con servers pre-hechos como GitHub y Sentry, luego crea tus propios servers personalizados para tu stack específico.

---

**¿Preguntas?** Consulta la [documentación oficial de MCP](https://modelcontextprotocol.io/)
