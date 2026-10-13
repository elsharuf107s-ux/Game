#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/runtime-$USER}"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

pkill -f 'Xvfb :1' 2>/dev/null || true
pkill -f 'x11vnc.*5901' 2>/dev/null || true
pkill -f 'websockify.*6080' 2>/dev/null || true

Xvfb :1 -screen 0 1440x900x24 -ac +extension GLX +render -noreset >/tmp/xvfb.log 2>&1 &
sleep 1

dbus-launch --exit-with-session startxfce4 >/tmp/xfce.log 2>&1 &
sleep 2

x11vnc -display :1 -rfbport 5901 -forever -shared -nopw -localhost >/tmp/x11vnc.log 2>&1 &
websockify --web=/usr/share/novnc/ 6080 localhost:5901 >/tmp/novnc.log 2>&1 &

if [ -x /opt/ghidra/ghidraRun ]; then
  nohup /opt/ghidra/ghidraRun >/tmp/ghidra-gui.log 2>&1 &
fi

echo "Ghidra desktop ready: http://localhost:6080/vnc.html"
