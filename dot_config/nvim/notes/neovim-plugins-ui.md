# Neovim Plugins: UI

## Colorscheme: Dracula (`Mofiqul/dracula.nvim`)

Applied globally with high priority.

## Lualine (`nvim-lualine/lualine.nvim`)

Statusline with `dracula-nvim` theme.

**Custom sections:**
- `lualine_b`: branch, diff, diagnostics, Grapple status (shows `󰛢` + tag name/index)
- `lualine_x`: encoding, fileformat, filetype

## OpenCode (`nickjvandyke/opencode.nvim`)

AI-assisted coding UI. Integrates with Snacks picker for action selection and input.

- Adds `<a-a>` key in picker input for sending
- Requires `autoread = true` for file reload

## HelpView (`OXY2DEV/helpview.nvim`)

Enhanced help file viewer.

## Trouble (`folke/trouble.nvim`)

Diagnostics/symbols/references viewer.

**Auto-open:** On `DiagnosticChanged` with severity >= WARN, auto-opens Trouble diagnostics. Closes automatically when no more warnings/errors.

## UFO (`kevinhwang91/nvim-ufo`)

Advanced folding with Treesitter + indent providers.

- Custom fold text handler shows line count with `` icon
- Auto-saves/restores folds via `mkview`/`loadview` on buffer leave/enter
- Fold column width: 1

## Render Markdown (`MeanderingProgrammer/render-markdown.nvim`)

Enhanced markdown rendering for `.md` and `codecompanion` filetypes.

- Conceal level 2 in rendered mode
- LaTeX rendering disabled (handled by Snacks.image)
