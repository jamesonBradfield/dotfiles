# Neovim Keymaps

All keybindings are centrally defined in `lua/keys.lua` as named tables, then imported by each plugin config. This keeps bindings discoverable and organized.

## Plugin-Specific Key Groups

### Mini.Files
| Key | Action |
|-----|--------|
| `<C-f>` | Toggle mini.files explorer |

### Persistence (Session Management)
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for current dir |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Grapple (File Bookmarks)
| Key | Action |
|-----|--------|
| `<leader>m` | Toggle tag on current file |
| `<leader>M` | Open tags window |
| `<leader>1`-`4` | Select tagged file by index |

### Todo Comments
| Key | Action |
|-----|--------|
| `]t` / `[t` | Next/previous TODO comment |
| `<leader>xt` | Todo list (Trouble) |
| `<leader>xT` | Todo/Fix/Fixme (Trouble) |

### DAP (Debugging)
| Key | Action |
|-----|--------|
| `<F5>` | Godot: Run Project |
| `<F6>` | Godot: Run Current Scene |
| `<leader>gd` | Godot: Class Documentation |
| `<leader>gh` | Godot: Method Hover (LSP) |
| `<F10>`-`<F12>` | Step Over/Into/Out |
| `<leader>b` | Toggle breakpoint |

### UFO (Folding)
| Key | Action |
|-----|--------|
| `zR` / `zM` | Open/close all folds |
| `zr` / `zm` | Open/close folds by kind |
| `zp` | Peek fold content |

### LSP (Attach-Time)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action (n/v) |
| `<leader>D` | Type definition |

### Telekasten (Zettelkasten)
| Key | Action |
|-----|--------|
| `<leader>k` | Open panel |
| `<leader>kf` | Find notes |
| `<leader>kg` | Search notes |
| `<leader>kd` | Go to today |
| `<leader>kz` | Follow link |
| `<leader>kn` | New note |
| `<leader>kc` | Calendar |
| `<leader>kb` | Backlinks |
| `<leader>kI` | Insert image link |
| `[[` (insert) | Insert note link |

### OpenCode (AI)
| Key | Action |
|-----|--------|
| `<C-a>` | Ask with `@this` |
| `<C-x>` | Select action |
| `<C-.>` | Toggle panel |
| `go` / `goo` | Operator: add range/line |
| `<S-C-u>` / `<S-C-d>` | Scroll up/down |

### Trouble
| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Symbols |
| `<leader>cl` | LSP references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

### Flash (Motion)
| Key | Mode | Action |
|-----|------|--------|
| `s` | n/x/o | Jump |
| `S` | n/x/o | Treesitter jump |
| `r` | o | Remote flash |
| `R` | o/x | Treesitter search |
| `<c-s>` | c | Toggle flash search |

### CodeCompanion
| Key | Action |
|-----|--------|
| `<leader>cc` | Open AI chat |
| `<leader>ca` | AI actions |

### Git
| Key | Action |
|-----|--------|
| `<leader>gh` | Preview hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gg` | Open Neogit |
| `<leader>gc` | Neogit commit |

### Snacks (Utilities)
| Key | Action |
|-----|--------|
| `<leader>tb` | Toggle Bacon build terminal |
| `<leader>sr` | Search recent files |
| `<leader>n` | Notification history |
| `<leader>sc` | Search config files |
| `<leader>sh` | Search help |
| `<leader>sf` | Search files |
| `<leader>sg` | Search grep |
| `<leader>z` | Zen mode |

### Smart Splits (Window Navigation)
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move cursor between windows (n/t modes) |

Smart detection: if in a Snacks picker or mini.files buffer, uses native `wincmd`; otherwise uses `smart-splits` for resizing-aware movement.

### Which-Key
| Key | Action |
|-----|--------|
| `<leader>?` | Show buffer-local keymaps |
