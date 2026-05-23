local keys = require 'keys'

return {
  {
    -- Catppuccin Colorscheme (matches WezTerm color_scheme)
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      transparent_background = false,
      term_colors = true,
      dim_inactive = { enabled = false },
      integrations = {
        cmp = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        lualine = true,
        markdown = true,
        mason = true,
        neotree = true,
        notify = true,
        native_lsp = { enabled = true },
        telescope = { enabled = false }, -- Using snacks picker
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    -- Lualine
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local function grapple_status()
        local ok, grapple = pcall(require, 'grapple')
        if ok and grapple.exists() then
          return '󰛢 ' .. grapple.name_or_index()
        end
        return ''
      end

      require('lualine').setup {
        options = { theme = 'catppuccin' },
        sections = {
          lualine_b = {
            'branch',
            'diff',
            'diagnostics',
            { grapple_status, color = { fg = '#8be9fd', gui = 'bold' } },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
        },
      }
    end,
  },
  {
    -- Opencode.nvim integration
    'nickjvandyke/opencode.nvim',
    version = '*', -- Latest stable release
    lazy = false,
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks"
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    keys = keys.opencode,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}
      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  },
  { 'OXY2DEV/helpview.nvim', lazy = false },
  {
    -- Trouble
    'folke/trouble.nvim',
    keys = keys.trouble,
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd('DiagnosticChanged', {
        group = vim.api.nvim_create_augroup('AutoTrouble', { clear = true }),
        callback = function()
          local diags = vim.diagnostic.get(nil, { severity = { min = vim.diagnostic.severity.WARN } })
          local trouble = require 'trouble'
          if #diags > 0 then
            trouble.open { mode = 'diagnostics', focus = false }
          else
            if trouble.is_open 'diagnostics' then
              trouble.close 'diagnostics'
            end
          end
        end,
      })
    end,
  },
  {
    -- UFO
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufRead',
    keys = keys.ufo,
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      local view_group = vim.api.nvim_create_augroup('AutoView', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWinLeave' }, { pattern = '?*', group = view_group, command = 'mkview' })
      vim.api.nvim_create_autocmd({ 'BufWinEnter' }, { pattern = '?*', group = view_group, command = 'silent! loadview' })

      require('ufo').setup {
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
  {
    -- Render Markdown
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { latex = { enabled = false }, win_options = { conceallevel = { rendered = 2 } } },
  },
}
