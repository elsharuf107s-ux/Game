# Ghidra + REA in GitHub Codespaces

This repository runs two browser-accessible services in one Codespace:

- Port `3000`: REA Browser Workbench
- Port `6080`: XFCE desktop through noVNC, with Ghidra launched automatically

## First launch
1. Create a Codespace for this repository.
2. Add `OPENAI_API_KEY` as a Codespaces secret if GitHub prompts for it.
3. Wait for the devcontainer setup to finish.
4. Open the **PORTS** panel.
5. Open port `3000` for the REA workbench.
6. Open port `6080` and append `/vnc.html` if needed.
7. In the Ghidra desktop, complete any first-run prompt, then create/import a project as normal.

Keep both forwarded ports private unless you intentionally want to share them.

## Verify
```bash
bash scripts/check-setup.sh
```

## Restart services
```bash
bash scripts/start-all.sh
```

## Logs
```bash
tail -f /tmp/rea-workbench.log
tail -f /tmp/ghidra-gui.log
tail -f /tmp/novnc.log
```

REA uses Ghidra headlessly for native analysis. noVNC lets you also use the full Ghidra GUI from a Chromebook or other browser-only machine.

Only analyze software, binaries, and firmware that you own or are authorized to inspect.
