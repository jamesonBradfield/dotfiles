# Neovim Plugins: Debugging

Defined in `dap.lua` (formerly `debugging.lua`).

## nvim-dap (`mfussenegger/nvim-dap`)

Core debugging engine.

### Adapters

| Language     | Adapter  | Type                                  |
| ------------ | -------- | ------------------------------------- |
| Rust         | CodeLLDB | Server (port)                         |
| Python       | debugpy  | Executable (launch) / Server (attach) |
| Lua (Neovim) | nlua     | Server (attach on port 8086)          |
| GDScript     | godot    | Server (port 6006)                    |

### Launch Configurations

- **Python:** Launch current file with system Python
- **Rust:** Launch Godot executable with `--path` argument and `codelldb`
- **Lua:** Attach to running Neovim instance
- **GDScript:** Attach Godot Debugger to `${workspaceFolder}`

## DAP UI (`rcarriga/nvim-dap-ui`)

Visual debug interface.

- Auto-opens on attach/launch
- Auto-closes on terminate/exit
