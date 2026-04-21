#!/usr/bin/env bash
set -euo pipefail

echo "== Cloud Doctor =="
echo "Workspace: $(pwd)"
echo "Date: $(date -Iseconds)"

echo
echo "-- System --"
uname -a
df -h . || true
free -h || true

echo
echo "-- Tooling --"
git --version || true
gh --version | head -n 1 || true
node --version || true
npm --version || true
python --version || true

echo
echo "-- Git --"
git status --short --branch || true

echo
echo "-- Project checks --"
if [ -f web-app/package.json ]; then
  cd web-app
  npm run lint || true
  npm run build
elif [ -f package.json ]; then
  npm test --if-present
else
  echo "No Node project detected at root."
fi
