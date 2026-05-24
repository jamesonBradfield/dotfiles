# Neovim Plugins: Core

## Mini.Files (`nvim-mini/mini.nvim`)

File explorer that behaves like a text buffer. Lazy-loaded when Neovim is started with a directory argument.

- Custom filter hides Godot sidecar files (`.uid`, `.import`)
- Preview window, 30/50 width split
- Set as default explorer
- Auto-attaches Grapple keymap on `MiniFilesBufferCreate` — `<leader>m` toggles tags on files

## Mason (`mason-org/mason.nvim`)

LSP/DAP/formatter installer. No custom opts beyond defaults.

## Treesitter (`nvim-treesitter/nvim-treesitter`)

Syntax highlighting and parsing.

**Parsers installed:** bash, gdscript, godot_resource, gdshader, lua, vim, vimdoc, markdown, markdown_inline, python
**Auto-install:** enabled
**Highlight:** enabled
**Indent:** enabled

## Snacks (`folke/snacks.nvim`)

Massive utility collection. The backbone of UI interactions.

### Enabled Modules
- bigfile, dashboard, indent, input, notifier, quickfile, scope, scroll, words, statuscolumn, zen, terminal, picker

### Picker
- Layout: `vscode` preset
- File explorer: hidden files shown, excludes `*.uid` and `*.import`
- Files: hidden files shown

### Terminal
- Position: right, width 40%

### Image/Math
- Inline images disabled, float enabled
- Math rendering with LaTeX (amsmath, amssymb, amsfonts, amscd, mathtools)

### Autocommands
- **Rust file open:** Auto-initializes a hidden terminal for `bacon clippy` with RUST_BACKTRACE=1, 12 parallel jobs, isolated target dir
- **Rename hook:** Intercepts `Snacks.rename.on_rename_file` to also rename Godot sidecar files (`.uid`, `.import`)

## IWE (`iwe-org/iwe.nvim`)

Knowledge management with LSP/CLI (`iwes`). Integrated with Snacks.

- LSP: `iwes` command, auto-format on save
- Markdown mappings enabled
- Telescope integration with ui-select and emoji extensions
- Leader: `<leader>`, LocalLeader: `<localleader>`
