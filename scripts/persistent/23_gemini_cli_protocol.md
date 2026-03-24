# Gemini CLI Integration Protocol (Nexus Core)

Based on video `4JcL3VS19g4`, we implement the **Gemini CLI** for fast, local AI interaction that bypasses browser lag.

## 🛠️ Installation

1. Ensure Python 3.10+ is installed.
2. Install via pip:

   ```bash
   pip install google-generativeai
   ```

3. Configure API Key in environment:

   ```powershell
   $env:GEMINI_API_KEY = "YOUR_KEY"
   ```

## 🚀 Usage in Nexus

We use the `23_gemini_cli_integration.py` script to bridge local research with the cloud.

### Features

- **Prompt Injection**: Automated injection of research logs into Gemini.
- **Flash Unlimited**: Optimized for `gemini-1.5-flash` for high-speed processing of the 350-page thesis.
