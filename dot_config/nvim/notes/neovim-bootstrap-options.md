# Neovim Bootstrap & Options

## Entry Point: `init.lua`

- Bootstraps **lazy.nvim** (clones if missing)
- Loads `lua/opts.lua` for global settings
- Calls `require('lazy').setup('plugins')` to load all plugins from `lua/plugins/`
- Registers the `<leader>v` keymap for **Voice Ducky** (terminal toggle via Snacks or plain vsplit)

## Options: `lua/opts.lua`

### General

| Setting | Value | Description |
|---------|-------|-------------|
| `mapleader` | Space | Leader key |
| `maplocalleader` | `\\` | Local leader |
| `shell` | `/bin/bash` (Linux), MSYS2 zsh (Windows) | Shell for :! commands |

### Editor

- `relativenumber + number` — hybrid line numbers
- `clipboard = unnamedplus` — system clipboard
- `undofile = true` — persistent undo
- `autoread = true` — auto-reload (required for OpenCode)
- `incsearch / ignorecase / smartcase` — smart search
- `expandtab, tabstop=2, shiftwidth=2, softtabstop=2` — 2-space indents
- `signcolumn = yes` — always visible
- `updatetime = 250, timeoutlen = 500, ttimeoutlen = 50` — responsive UI
- `termguicolors = true` — 24-bit color
- `conceallevel = 2` — conceal for render-markdown (LaTeX)
- `guicursor` — custom cursor shapes/blink

### Diagnostics

- Floating window with rounded border, source shown
- Auto-opens on `CursorHold`
- Custom Nerd Font icons: `` Error, `` Warn, `` Hint, `` Info

### Autocommands

- `<Esc>` maps to `nohlsearch` — clear search highlights
- `BufWritePost *.rs` — auto-builds GDExtension via `cargo build`, notifies on result
