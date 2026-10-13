#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.ghidra-env" 2>/dev/null || true

echo "== Versions =="
node --version || true
npm --version || true
java -version || true

echo

echo "== Ghidra =="
echo "GHIDRA_INSTALL_DIR=${GHIDRA_INSTALL_DIR:-unset}"
test -x "${GHIDRA_INSTALL_DIR:-/opt/ghidra}/support/analyzeHeadless" && echo "analyzeHeadless: OK" || echo "analyzeHeadless: MISSING"

echo

echo "== REA =="
npx -y rea-agents@latest doctor --json || true

echo

echo "== Services =="
curl -fsS http://127.0.0.1:3000 >/dev/null && echo "port 3000: OK" || echo "port 3000: DOWN"
curl -fsS http://127.0.0.1:6080/vnc.html >/dev/null && echo "port 6080: OK" || echo "port 6080: DOWN"
