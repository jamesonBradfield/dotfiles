# Neovim Plugins: Language Support

Defined in `lang.lua` (formerly `lang_stack.lua`). Organized into two clear sections.

## Section 1: Formatting & Linting Infrastructure

Loads on `BufReadPre`/`BufNewFile` for **all** filetypes.

### Conform (`stevearc/conform.nvim`)

Formatter manager. Auto-formats on save with 500ms timeout, falls back to LSP formatting.

| Filetype | Formatter                           |
| -------- | ----------------------------------- |
| lua      | stylua                              |
| python   | ruff_format + ruff_organize_imports |
| json     | prettier                            |

### Nvim-Lint (`mfussenegger/nvim-lint`)

Linter manager. Runs on `BufWritePost`.

| Filetype | Linter  |
| -------- | ------- |
| python   | ruff    |
| yaml     | yamlfmt |

## Section 2: Language-Specific Plugins

Loaded **only by filetype** (not at startup).

### Rustaceanvim (`mrcjkb/rustaceanvim`)

- **Loads on:** `ft = 'rust'`
- **Root detection:** `Cargo.toml`
- **Key overrides in Rust buffers:**
  - `K` → `RustLsp hover actions` (shows hover + code actions in one window)
  - `<leader>ca` → `RustLsp codeAction`
- **rust-analyzer settings:**
  - Proc macros enabled (godot/godot_macros ignored)
  - All features, out-dir from check, build scripts
  - Check on save via Clippy
  - Diagnostics: suppresses `unresolved-proc-macro`, `proc-macro-disabled`

### Godotdev (`Mathijs-Bakker/godotdev.nvim`)

- **Loads on:** `ft = { gdscript, gdscript3, gdshader, gdresource }`
- Editor host: `127.0.0.1` (works across WSL2 + Windows)
- Godot executable: `Godot_v4.6.2-stable_win64.exe`
- Formatter: `gdformat`
- Treesitter auto-setup: disabled (managed in core.lua)
