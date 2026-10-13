#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.ghidra-env" 2>/dev/null || true

nohup bash scripts/start-desktop.sh >/tmp/start-desktop.log 2>&1 &
nohup npm start >/tmp/rea-workbench.log 2>&1 &

echo "REA Workbench: http://localhost:3000"
echo "Ghidra Desktop: http://localhost:6080/vnc.html"
