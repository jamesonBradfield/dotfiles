local keys = require 'keys'

return {
  {
    -- Gitsigns
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
    },
    keys = keys.gitsigns,
  },
  {
    -- Neogit
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    cmd = 'Neogit',
    keys = keys.neogit,
    config = function()
      require('neogit').setup { integrations = { diffview = true }, disable_commit_confirmation = true }
    end,
  },
  {
    -- CodeCompanion
    'olimorris/codecompanion.nvim',
    branch = 'main',
    enabled = true,
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = keys.codecompanion,
    init = function()
      if vim.fn.has 'win32' == 1 then
        vim.env.PATH = 'C:\\Windows\\System32;' .. vim.env.PATH
      end
    end,
    opts = {
      adapter = 'deepseek',
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = "cmd:printenv DEEPSEEK_API_KEY | tr -d '\\r\\n '",
            },
          })
        end
      },
      strategies = {
        chat = { adapter = 'deepseek' },
        inline = { adapter = 'deepseek' },
      },
      mcp = {
        servers = {
          iwe = {
            cmd = { "iwec" },
          },
          -- thunk = {
          --   cmd = { "/home/mcraf/Projects/thunk/.venv/bin/python", "/home/mcraf/Projects/thunk/mcp_server.py" },
          --   env = {
          --     THUNK_MODEL = "openai/Qwen3.5-9B-Q6_K.gguf",
          --     THUNK_API_BASE = "http://localhost:8080/v1",
          --     OPENAI_API_KEY = "sk-no-key-required",
          --     THUNK_SHELL = "/bin/bash",
          --     THUNK_INTENT_COLLAPSE = "500",
          --   },
          -- },
        },
        opts = {
          default_servers = { "iwe" },
        },
      },
      display = { action_palette = { provider = 'snacks' } },
    },
  }
}
