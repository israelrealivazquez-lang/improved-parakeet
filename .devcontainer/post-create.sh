#!/usr/bin/env bash
set -euo pipefail

echo "== Nexus cloud bootstrap =="

python -m pip install --upgrade pip
python -m pip install --user python-docx playwright requests python-dotenv rich streamlit

if [ -f package.json ]; then
  npm ci --prefer-offline --no-audit --fund=false || npm install --no-audit --fund=false
fi

if [ -f web-app/package.json ]; then
  cd web-app
  npm ci --prefer-offline --no-audit --fund=false || npm install --no-audit --fund=false
  cd ..
fi

if command -v playwright >/dev/null 2>&1; then
  playwright install chromium || true
fi

mkdir -p .cache .nexus-runtime

echo "Bootstrap complete. Run: bash scripts/cloud-doctor.sh"
