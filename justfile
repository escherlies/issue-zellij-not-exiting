dev-layout:
  bun server.js 3001 "Layout -> pan.command = just, pane.args = dev-cli"

dev-cli:
  bun server.js 3003 "Cli -> just dev-cli"