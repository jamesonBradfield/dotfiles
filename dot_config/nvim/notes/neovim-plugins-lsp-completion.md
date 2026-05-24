# Neovim Plugins: LSP & Completion

## Blink.cmp (`saghen/blink.cmp`)

Lightning-fast Rust-based completion engine.

- Preset: `super-tab` keymap
- `<CR>`: accept or fallback
- Auto-show documentation
- **Sources:** lazydev, lsp, path, snippets, buffer (in priority order)
- LazyDev integration with +100 score offset

## nvim-lspconfig (`neovim/nvim-lspconfig`)

Standard LSP client configuration.

### Global LSP Keymaps
Attached via `LspAttach` autocommand — see the [[Neovim Keymaps]] document for the full list (gd, gD, gr, gi, K, etc.)

### Enabled Servers (Neovim 0.11+ `vim.lsp.enable`)
- `lua_ls` — Lua
- `bashls` — Bash
- `basedpyright` — Python
- `json-lsp` — JSON

### Godot WSL Bridge
- Filetypes: `gdscript`, `gdscript3`
- Command: `godot-wsl-lsp --host 172.23.32.1`
- Root markers: `project.godot`, `.git`
- Manual start command: `:GodotStartLSP`

## LazyDev (`folke/lazydev.nvim`)

Injects Neovim API types into Lua LSP.

- Libraries: luv (for `vim.uv`), wezterm-types