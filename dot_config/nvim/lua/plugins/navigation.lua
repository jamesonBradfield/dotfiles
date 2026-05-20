local keys = require 'keys'

return {
  {
    -- Persistence
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = keys.persistence,
  },
  {
    -- Grapple
    'cbochs/grapple.nvim',
    opts = { scope = 'git' },
    cmd = 'Grapple',
    keys = keys.grapple,
  },
  {
    -- Flash
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    config = function(_, opts)
      require('flash').setup(opts)
      -- Prevent flash from attaching to mini.files or checkhealth
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'minifiles', 'checkhealth' },
        callback = function()
          vim.b.flash_enabled = false
        end,
      })
    end,
    keys = keys.flash,
  },
  {
    -- Smart Splits
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    keys = keys.smart_splits,
    opts = { multiplexer_integration = 'wezterm' },
  },
  {
    -- Which-Key
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      spec = {
        { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
        { '<leader>d', group = 'Document' },
        { '<leader>g', group = 'Git' },
        { '<leader>q', group = 'Session/Quit' },
        { '<leader>s', group = 'Search' },
        { '<leader>x', group = 'Trouble/Diagnostics' },
        { '<leader>k', group = 'Telekasten' },
        { '<leader>t', group = 'Toggle/Terminal' },
      },
    },
    keys = keys.which_key,
  },
  {
    -- Todo-Comments
    'folke/todo-comments.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = keys.todo_comments,
    opts = {},
  },
}
