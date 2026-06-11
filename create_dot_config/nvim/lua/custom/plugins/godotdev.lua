return {
  "Mathijs-Bakker/godotdev.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("godotdev").setup({
      -- Godot executable to use, you can also provide an absolute path
      -- such as 'C:/Users/mcraf/AppData/Local/Microsoft/WinGet/Packages/GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe/Godot_v4.6.3-stable_win64.exe'
      -- if 'godot.exe' is not in your Windows PATH.
      -- godot_executable = 'godot.exe'
    })

    -- Workaround for godotdev.nvim forcing 'ncat' on Windows.
    -- Neovim 0.10+ supports native TCP RPC connections on Windows!
    if vim.lsp.config and vim.lsp.config.gdscript then
      vim.lsp.config.gdscript.cmd = vim.lsp.rpc.connect('127.0.0.1', 6005)
    end
  end
}
