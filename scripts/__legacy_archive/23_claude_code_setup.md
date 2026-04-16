# Claude Code & OpenRouter Setup (Nexus Core)

Based on video `vAJFjuXm4mU`, we integrate **Claude Code** to enable high-level architectural reasoning via CLI.

## 🛠️ Configuration
1. Install Claude CLI:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
2. Configure OpenRouter as a bridge for alternative models:
   - Use the `OPENROUTER_API_KEY` in environment variables.
3. Link with Nexus Core:
   - Claude Code is used to perform audits on `NEXUS_MASTER_PROTOCOL.md`.

## 🚀 Workflow
1. Run `claude-code` in the root directory.
2. Use it to refactor existing persistence scripts.
