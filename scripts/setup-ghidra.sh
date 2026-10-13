#!/usr/bin/env bash
set -euo pipefail

GHIDRA_VERSION="12.1.4"
GHIDRA_RELEASE="20260921"
GHIDRA_DIR="/opt/ghidra_${GHIDRA_VERSION}_PUBLIC"
GHIDRA_ZIP="/tmp/ghidra.zip"
GHIDRA_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${GHIDRA_VERSION}_build/ghidra_${GHIDRA_VERSION}_PUBLIC_${GHIDRA_RELEASE}.zip"

if [ ! -d "$GHIDRA_DIR" ]; then
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-21-jdk xfce4 xfce4-goodies dbus-x11 x11vnc xvfb \
    novnc websockify wget unzip curl ca-certificates procps

  wget -q --show-progress -O "$GHIDRA_ZIP" "$GHIDRA_URL"
  sudo unzip -q "$GHIDRA_ZIP" -d /opt
  rm -f "$GHIDRA_ZIP"
fi

sudo ln -sfn "$GHIDRA_DIR" /opt/ghidra
JAVA_HOME_PATH="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"

cat > "$HOME/.ghidra-env" <<EOF
export GHIDRA_INSTALL_DIR=/opt/ghidra
export JAVA_HOME=$JAVA_HOME_PATH
export REA_ANALYSIS_PROVIDER=ghidra
EOF

grep -q 'source "$HOME/.ghidra-env"' "$HOME/.bashrc" 2>/dev/null || echo 'source "$HOME/.ghidra-env"' >> "$HOME/.bashrc"

echo "Ghidra ready: /opt/ghidra"
echo "JAVA_HOME=$JAVA_HOME_PATH"
