# REA Browser Workbench

A GitHub Codespaces setup for running **Reverse Engineer Anything (REA)** through a browser-accessible port and optionally asking the OpenAI API to explain REA evidence.

## Start it

1. On this repository, click **Code → Codespaces → New with options**.
2. GitHub will show the recommended `OPENAI_API_KEY` secret from `.devcontainer/devcontainer.json`. Paste your OpenAI API key there.
   - Do **not** put the key in this repository, `.env`, browser JavaScript, or a chat message.
3. Create the Codespace.
4. The devcontainer installs Node 24, runs `npm install`, and starts the web workbench.
5. Port **3000** is forwarded automatically. Codespaces should open the app in a browser. If not, open the **PORTS** tab and click the URL for port 3000.

GitHub Codespaces forwarded ports are private by default. Keep port 3000 private because the workbench can use your OpenAI API key.

## What the browser can do

- Upload a target into `targets/` inside the Codespace.
- Run a controlled set of REA commands:
  - `analyze`
  - `inspect`
  - `search`
  - `analyze-javascript-application`
  - `doctor`
  - `capabilities`
  - `providers`
- Send the current REA output to OpenAI for explanation.

The browser never receives `OPENAI_API_KEY`; the Node server reads it from the Codespace environment and calls the OpenAI Responses API server-side.

## Notes about REA

REA itself is primarily a CLI and MCP server. Its MCP transport is stdio, so this repository adds a small web wrapper on port 3000 rather than pretending the MCP server is an HTTP app.

Static JavaScript/Electron inspection can work without a native decompiler. Native binary analysis requires a supported provider such as Ghidra, Hopper, or IDA configured inside the environment.

## Useful terminal commands

```bash
npx rea-agents doctor
npx rea-agents capabilities
npx rea-agents providers
npm start
```

To inspect the app log when it was started automatically:

```bash
cat /tmp/rea-workbench.log
```

To restart the browser server manually:

```bash
pkill -f "node server.js" || true
npm start
```

## OpenAI model

The default is set by `OPENAI_MODEL` in `.devcontainer/devcontainer.json`. Change that environment value if your API project uses a different model.

## Use responsibly

Only analyze software, binaries, websites, or applications you are authorized to inspect. Respect applicable licenses, terms, privacy rules, and laws.
