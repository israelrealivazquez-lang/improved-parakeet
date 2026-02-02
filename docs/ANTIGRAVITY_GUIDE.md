# Guía Completa de Google Antigravity

## ¿Qué es Google Antigravity?

Google Antigravity es un IDE con IA lanzado por Google en noviembre de 2025, que combina un entorno de desarrollo potente con capacidades de agentes autónomos. Está disponible en preview público de forma gratuita.

## Características Principales

### 1. Agent-First Development

Antigravity permite que agentes de IA trabajen de manera autónoma:
- Planificación de tareas complejas
- Ejecución en editor, terminal y navegador
- Verificación automática de resultados

### 2. Modelos Soportados

- **Gemini 3 Pro**: Gratuito con límites generosos
- **Claude Sonnet 4.5**: Soporte completo de Anthropic
- **GPT-OSS**: Modelos de OpenAI

### 3. Model Context Protocol (MCP)

Antigravity se conecta con el ecosistema de Google Cloud mediante MCP, permitiendo:
- Integración con servicios externos
- Compatibilidad con Claude Code CLI
- Soporte completo para tool calls y streaming

## Instalación

### macOS

```bash
# Opción 1: Descarga directa
# Visita: https://antigravity.dev/download

# Opción 2: Homebrew (cuando esté disponible)
brew install --cask google-antigravity
```

**Requisitos:**
- macOS Monterey (12) o superior
- 8GB RAM mínimo (16GB recomendado)
- Recomendado: Apple Silicon (M1/M2/M3/M4)

### Windows

1. Descarga el instalador desde: https://antigravity.dev/download
2. Ejecuta el instalador `.exe`
3. Sigue las instrucciones en pantalla

**Requisitos:**
- Windows 10 o superior
- 8GB RAM mínimo
- 2GB de espacio en disco

### Linux

```bash
# Descarga el .AppImage o .deb desde:
# https://antigravity.dev/download

# Para .deb:
sudo dpkg -i google-antigravity.deb
sudo apt-get install -f

# Para .AppImage:
chmod +x Google-Antigravity.AppImage
./Google-Antigravity.AppImage
```

## Primer Uso

### 1. Configuración Inicial

Al abrir Antigravity por primera vez:

1. **Inicia sesión con Google**
   - Usa tu cuenta de Google personal o de trabajo
   - Acepta los términos de servicio

2. **Selecciona tu modelo preferido**
   - **Gemini 3 Pro**: Recomendado para empezar (gratis)
   - **Claude Sonnet 4.5**: Si tienes API key de Anthropic
   - **GPT-4**: Si tienes API key de OpenAI

3. **Configura tu workspace**
   - Selecciona o crea una carpeta de proyecto
   - Antigravity indexará tu código

### 2. Interfaz Principal

La interfaz de Antigravity tiene tres áreas principales:

```
┌─────────────────────────────────────┐
│  Editor                    │ Chat   │
│  (Código)                  │ (IA)   │
│                           │        │
├─────────────────────────────────────┤
│  Terminal                           │
└─────────────────────────────────────┘
```

## Uso Básico

### Chat con el Agente

```
Tú: "Crea una función para validar emails"

Antigravity:
✓ Creando validador de email
✓ Agregando tests
✓ Ejecutando tests
✓ Todo funcionando correctamente

[El código aparece en el editor]
```

### Comandos Slash

Antigravity soporta comandos especiales:

- `/code <descripción>` - Generar código
- `/fix <error>` - Arreglar un error
- `/explain <código>` - Explicar código
- `/refactor <código>` - Refactorizar
- `/test` - Generar tests
- `/docs` - Generar documentación

### Ejemplo de Workflow

```bash
# 1. Crear componente
/code Crea un componente React para login con email y password

# 2. Agregar validación
/code Agrega validación de formulario con Yup

# 3. Escribir tests
/test

# 4. Ejecutar tests
npm test

# 5. Si hay errores
/fix Los tests están fallando porque...
```

## Integración con Claude CLI

Una de las características más poderosas es usar Claude CLI con los modelos gratuitos de Antigravity.

### Configuración

Ver [README.md](../README.md#-integración-antigravity--claude) para instrucciones detalladas.

### Ventajas

1. **Gratis**: Usa Claude Sonnet 4.5 sin pagar por API
2. **Mismo workflow**: Mantén tu flujo de trabajo de Claude Code
3. **Skills compatibles**: Tus skills de Claude funcionan sin cambios
4. **Google Search**: Acceso a búsqueda de Google integrada

## Skills y Extensiones

### Instalar Skills Personalizados

Antigravity es compatible con los skills de Claude Code:

```bash
# Clonar repositorio de skills
git clone https://github.com/sickn33/antigravity-awesome-skills.git

# Copiar a tu proyecto
cp -r antigravity-awesome-skills/skills ~/.antigravity/skills
```

### Skills Populares

- **Web Scraping**: Extraer datos de sitios web
- **API Testing**: Probar endpoints REST
- **Database**: Consultas y migraciones
- **Git**: Operaciones avanzadas de git
- **Deploy**: Despliegue automático

## MCP Servers

Antigravity soporta MCP servers para extender funcionalidad.

### Agregar MCP Server

En tu proyecto, crea `.mcp.json`:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "sentry": {
      "type": "http",
      "url": "https://mcp.sentry.dev/mcp"
    }
  }
}
```

### MCP Servers Recomendados

1. **GitHub** - Gestión de repos y PRs
2. **Sentry** - Monitoreo de errores
3. **PostgreSQL** - Consultas de base de datos
4. **Stripe** - Integración de pagos
5. **Notion** - Gestión de documentación

## Límites y Rate Limits

### Cuenta Gratuita (Google estándar)

- **Gemini 3 Pro**: Límite generoso, suficiente para uso diario
- **Claude/GPT**: Requiere tu propia API key

### Google One Subscribers

- **Límites aumentados**: Más requests por minuto
- **Prioridad**: Menor latencia
- **Storage**: Más espacio para proyectos

## Casos de Uso

### 1. Desarrollo Web

```
Tú: Crea una landing page moderna con Tailwind CSS

Antigravity:
✓ Estructura HTML
✓ Estilos Tailwind
✓ Animaciones
✓ Responsive design
✓ Preview en navegador
```

### 2. Backend APIs

```
Tú: Crea un API REST en Node.js con Express para gestionar usuarios

Antigravity:
✓ Setup de Express
✓ Rutas CRUD
✓ Validación con Joi
✓ Tests con Jest
✓ Documentación OpenAPI
```

### 3. Data Science

```
Tú: Analiza este dataset de ventas y crea visualizaciones

Antigravity:
✓ Carga de datos con pandas
✓ Limpieza de datos
✓ Análisis estadístico
✓ Gráficos con matplotlib
✓ Reporte en notebook
```

### 4. DevOps

```
Tú: Crea un Dockerfile y GitHub Actions para CI/CD

Antigravity:
✓ Dockerfile optimizado
✓ docker-compose.yml
✓ GitHub Actions workflow
✓ Tests automatizados
✓ Deploy a Cloud Run
```

## Solución de Problemas

### Antigravity no inicia

**Síntoma**: La aplicación no abre o crash al inicio

**Solución**:
```bash
# macOS
rm -rf ~/Library/Application\ Support/Antigravity
# Reinstalar

# Windows
# Eliminar: C:\Users\<TU_USUARIO>\AppData\Roaming\Antigravity
# Reinstalar

# Linux
rm -rf ~/.config/Antigravity
# Reinstalar
```

### Modelo no responde

**Síntoma**: El agente no genera respuestas

**Solución**:
1. Verifica tu conexión a Internet
2. Revisa si alcanzaste el rate limit
3. Cambia de modelo temporalmente
4. Reinicia Antigravity

### Error de autenticación

**Síntoma**: "Authentication failed"

**Solución**:
1. Cierra sesión en Antigravity
2. Borra cookies: Settings → Clear Data
3. Inicia sesión nuevamente
4. Si persiste, usa otro navegador para autorizar

### Slow performance

**Síntoma**: Antigravity está lento

**Solución**:
1. Cierra proyectos innecesarios
2. Limpia caché: Settings → Clear Cache
3. Reduce tamaño del workspace
4. En macOS: Verifica Activity Monitor
5. Aumenta RAM asignada en Settings

## Recursos Adicionales

### Documentación Oficial

- [Antigravity Docs](https://antigravity.dev/docs)
- [Codelabs](https://codelabs.developers.google.com/getting-started-google-antigravity)
- [Blog de Google Developers](https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/)

### Comunidad

- [Discord](https://discord.gg/antigravity)
- [GitHub Discussions](https://github.com/google/antigravity/discussions)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/google-antigravity)

### Tutoriales

- [The 2026 Guide to Google Antigravity](https://www.aifire.co/p/google-antigravity-the-2026-guide-to-the-best-ai-ide)
- [How to Set Up and Use Google Antigravity - Codecademy](https://www.codecademy.com/article/how-to-set-up-and-use-google-antigravity)

## Comparación con Otras Herramientas

| Característica | Antigravity | Claude Code | Cursor | GitHub Copilot |
|---------------|-------------|-------------|---------|----------------|
| Precio | Gratis (preview) | $20/mes | $20/mes | $10/mes |
| Agentes | ✅ Autónomos | ✅ Avanzados | ⚠️ Básicos | ❌ No |
| Modelos | Gemini/Claude/GPT | Claude | GPT | GPT |
| MCP | ✅ Sí | ✅ Sí | ❌ No | ❌ No |
| Terminal | ✅ Integrado | ✅ CLI | ✅ Integrado | ❌ No |
| Browser | ✅ Integrado | ⚠️ Vía MCP | ❌ No | ❌ No |

## Mejores Prácticas

### 1. Estructura de Prompts

✅ **Bueno**:
```
Crea un componente React de formulario de login con:
- Campos: email y password
- Validación con Yup
- Manejo de errores
- Loading state
- Tests con Jest
```

❌ **Malo**:
```
haz un login
```

### 2. Iteración

En lugar de pedir todo de una vez, itera:

```
# Paso 1
Crea estructura básica del componente

# Paso 2
Agrega validación

# Paso 3
Agrega manejo de errores

# Paso 4
Escribe tests
```

### 3. Revisión de Código

Siempre revisa el código generado:
- ✅ Verifica lógica de negocio
- ✅ Revisa seguridad
- ✅ Ejecuta tests
- ✅ Lint y format

### 4. Control de Versiones

Commit frecuentemente cuando trabajes con IA:

```bash
# Después de cada cambio significativo
git add .
git commit -m "feat: componente de login generado por Antigravity"
```

## Conclusión

Google Antigravity representa el futuro del desarrollo con IA. Su enfoque en agentes autónomos y su gratuidad en preview lo hacen una herramienta indispensable para desarrolladores modernos.

Para sacar el máximo provecho:
1. Experimenta con diferentes modelos
2. Aprende a escribir buenos prompts
3. Integra con tu workflow actual
4. Comparte feedback con la comunidad

---

**¿Preguntas?** Únete a la [comunidad en Discord](https://discord.gg/antigravity)
