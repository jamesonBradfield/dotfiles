# Neovim Plugins: AI & Tools

## Gitsigns (`lewis6991/gitsigns.nvim`)

Git signs in the gutter with custom characters (┃, _, ‾, ~, ┆).

- Current line blame enabled (500ms delay)

## Neogit (`NeogitOrg/neogit`)

Magit-like Git interface.

- Integrates with diffview.nvim
- Commit confirmation disabled

## CodeCompanion (`olimorris/codecompanion.nvim`)

AI assistant with MCP support.

### Adapter: DeepSeek
- API key from `DEEPSEEK_API_KEY` environment variable
- Used for both chat and inline strategies

### MCP Servers
- **IWE** (`iwec`) — knowledge graph integration (default server)
- Thunk server available but commented out

### Display
- Action palette uses Snacks provider
