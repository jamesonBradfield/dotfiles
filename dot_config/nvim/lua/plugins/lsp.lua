local keys = require 'keys'

return {
  {
    -- Blink.cmp: A lightning-fast, Rust-based completion engine.
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<CR>'] = { 'accept', 'fallback' },
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    -- LSPConfig: The standard Neovim interface for communicating with LSPs.
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      -- Attach global LSP mappings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          for _, map in ipairs(keys.lsp_attach) do
            vim.keymap.set(map.mode or 'n', map[1], map[2], vim.tbl_extend('force', opts, { desc = map[3] }))
          end
        end,
      })

      -- Modern 0.11+ API for configuring and enabling servers
      -- Definitions are automatically merged from lspconfig/lsp/*.lua
      vim.lsp.enable 'lua_ls'
      vim.lsp.enable 'bashls'
      vim.lsp.enable 'basedpyright'
      vim.lsp.enable 'json-lsp'

      -- Godot LSP (mirrored networking – 127.0.0.1 works across WSL2 + Windows)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'gdscript', 'gdscript3' },
        callback = function(args)
          vim.lsp.config('gdscript', {
            cmd = { 'godot-wsl-lsp', '--host', '127.0.0.1' },
            root_markers = { 'project.godot', '.git' },
            -- Modern Neovim 0.11+ way to find root using buffer ID
            root_dir = function()
              return vim.fs.root(args.buf, { 'project.godot', '.git' }) or vim.uv.cwd()
            end,
          })
          vim.lsp.enable 'gdscript'
        end,
      })

      -- Manual command to force-start Godot LSP if it fails to attach
      vim.api.nvim_create_user_command('GodotStartLSP', function()
        vim.cmd 'set ft=gdscript'
        vim.cmd 'LspStart gdscript'
      end, {})

      -- Also start the Godot LSP automatically when entering a .gd buffer
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '*.gd', '*.gdshader' },
        callback = function()
          vim.schedule(function()
            local clients = vim.lsp.get_clients { name = 'gdscript' }
            if #clients == 0 then
              vim.cmd 'LspStart gdscript'
            end
          end)
        end,
        desc = 'Auto-start Godot LSP for .gd files',
      })
    end,
  },
  {
    -- LazyDev: Injects Neovim API types into the Lua LSP.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'wezterm-types',      mods = { 'wezterm' } },
      },
    },
  },
  { 'justinsgithub/wezterm-types', lazy = true },
}
