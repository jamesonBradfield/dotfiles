# Neovim Plugins: Editing & Navigation

Defined in `editing.lua` (formerly `navigation.lua`). Covers movement, bookmarks, session management, keymap hints, and annotation highlighting.

## Persistence (`folke/persistence.nvim`)

Session management — saves and restores sessions per directory.

## Grapple (`cbochs/grapple.nvim`)

File bookmarking scoped to Git projects. Tag files and jump between them quickly with `<leader>1`-`4`.

## Flash (`folke/flash.nvim`)

Enhanced motion — jump anywhere on screen with `s`.

- Search mode disabled (use Snacks picker instead)
- Disabled in `minifiles` and `checkhealth` buffers

## Smart Splits (`mrjones2014/smart-splits.nvim`)

Resize-aware split navigation with WezTerm multiplexer integration.

See [[Neovim Keymaps]] for the `<C-h/j/k/l>` logic.

## Which-Key (`folke/which-key.nvim`)

Keymap discoverability with Helix preset.

**Defined groups:**

| Prefix      | Group               |
| ----------- | ------------------- |
| `<leader>c` | Code                |
| `<leader>d` | Document            |
| `<leader>g` | Git                 |
| `<leader>q` | Session/Quit        |
| `<leader>s` | Search              |
| `<leader>x` | Trouble/Diagnostics |
| `<leader>k` | Telekasten          |
| `<leader>t` | Toggle/Terminal     |

## Todo-Comments (`folke/todo-comments.nvim`)

Highlight and jump between TODO, FIX, HACK, etc. comments.
