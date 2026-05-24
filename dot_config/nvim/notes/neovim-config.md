Full Neovim configuration for a Godot/Rust/Python development environment on Windows (WSL2) with WSLg.

## Overview

This config is managed via **lazy.nvim** with a modular plugin structure under `lua/plugins/`. The bootstrap entry point is `init.lua`, which loads options from `lua/opts.lua` and keymaps from `lua/keys.lua`.

### File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point: bootstrap lazy.nvim, load opts & plugins
├── ftdetect/
│   └── godot.lua               # Godot filetype detection
└── lua/
    ├── opts.lua                # Global vim options, diagnostics, auto-builds
    ├── keys.lua                # All keybindings (exported as named tables)
    └── plugins/
        ├── core.lua            # mini.files, mason, treesitter, snacks, iwe
        ├── ui.lua              # Colorscheme, lualine, opencode, trouble, ufo, markdown
        ├── lang_stack.lua      # rustaceanvim, godotdev, conform, nvim-lint
        ├── lsp.lua             # blink.cmp, nvim-lspconfig, lazydev
        ├── navigation.lua      # persistence, grapple, flash, smart-splits, which-key, todo-comments
        ├── ai_and_tools.lua    # gitsigns, neogit, codecompanion
        └── debugging.lua       # nvim-dap, dap-ui
```

### Key Design Decisions

- [[Neovim Plugins: Core]] — Snacks.nvim as the universal utility layer (picker, terminal, notifier, zen, etc.)
- [[Neovim Plugins: Core]] — IWE for knowledge management with the `iwec` MCP server in CodeCompanion
- [[Neovim Plugins: AI & Tools]] — CodeCompanion with DeepSeek adapter as primary AI assistant
- [[Neovim Plugins: LSP & Completion]] — Blink.cmp for completions (Rust-based, fast)
- [[Neovim Plugins: Navigation]] — Smart-splits with WezTerm multiplexer integration, patched for Snacks picker compatibility
- [[Neovim Plugins: Navigation]] — Grapple for file bookmarking (git-scoped), integrated into mini.files
- [[Neovim Plugins: Language Support]] — Rustaceanvim overrides standard LSP Hover/Action for Rust buffers
- [[Neovim Plugins: Language Support]] — Godotdev for Godot editor integration (WSL bridge via `godot-wsl-lsp`)

## Sections

- [[Neovim Bootstrap & Options]]
- [[Neovim Keymaps]]
- [[Neovim Plugins: Core]]
- [[Neovim Plugins: UI]]
- [[Neovim Plugins: Language Support]]
- [[Neovim Plugins: LSP & Completion]]
- [[Neovim Plugins: AI & Tools]]
- [[Neovim Plugins: Debugging]]
- [[Neovim Plugins: Navigation]]
- [[Neovim Filetype Detection]]