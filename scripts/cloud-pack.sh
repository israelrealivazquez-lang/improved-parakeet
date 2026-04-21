#!/usr/bin/env bash
set -euo pipefail

mkdir -p cloud-backup
{
  echo "# Local/Cloud Pack"
  echo
  echo "- Timestamp: $(date -Iseconds)"
  echo "- Commit: $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  echo
  echo "## Files"
  find . -maxdepth 3 -type f \
    ! -path "./.git/*" \
    ! -path "./node_modules/*" \
    | sort
} > cloud-backup/manifest.md

echo "Pack created at cloud-backup/manifest.md"
