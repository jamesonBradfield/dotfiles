return {
  {
    -- Rustaceanvim: A heavily optimized wrapper around rust-analyzer.
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        server = {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern 'Cargo.toml'(fname)
          end,
          on_attach = function(client, bufnr)
            -- Override standard Hover/Action keys with Rustacean's specialized UI
            vim.keymap.set('n', 'K', function()
              vim.cmd.RustLsp { 'hover', 'actions' }
            end, { silent = true, buffer = bufnr, desc = 'Rustacean: Hover Actions' })

            vim.keymap.set('n', '<leader>ca', function()
              vim.cmd.RustLsp 'codeAction'
            end, { silent = true, buffer = bufnr, desc = 'Rustacean: Code Action' })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              procMacro = {
                enable = true,
                ignored = {
                  ['godot'] = { 'godot_api' },
                  ['godot_macros'] = { 'godot_api' },
                },
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              check = { command = 'clippy' },
              diagnostics = { disabled = { 'unresolved-proc-macro', 'proc-macro-disabled' } },
            },
          },
        },
      }
    end,
  },
  {
    -- Godotdev: Comprehensive Godot integration.
    'Mathijs-Bakker/godotdev.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
    lazy = false,
    opts = {
      editor_host = '127.0.0.1',
      godot_executable = 'Godot_v4.6.2-stable_win64.exe',
      formatter = 'gdformat',
      treesitter = {
        auto_setup = false, -- Managed in core.lua
      },
    },
  },
  {
    -- Conform: Formatter manager.
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        json = { 'prettier' },
      },
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    },
  },
  {
    -- Nvim-Lint: Linter manager.
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = { python = { 'ruff' }, yaml = { 'yamlfmt' } }
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
          require('lint').try_lint 'cspell'
        end,
      })
    end,
  },
}
