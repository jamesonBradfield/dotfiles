local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


require 'opts'

require('lazy').setup 'plugins'

-- RPC server for external editor integration (Godot, etc.)
-- Creates a Unix socket at /tmp/nvim-server-$USER.sock
-- The godot_nvim_bridge script sends file-open commands here
vim.api.nvim_create_autocmd('UIEnter', {
  group = vim.api.nvim_create_augroup('RpcServer', { clear = true }),
  once = true,
  callback = function()
    local sock = '/tmp/nvim-server-' .. (vim.fn.getenv('USER') or 'nvim') .. '.sock'
    vim.fn.serverstart(sock)
    vim.notify('RPC server started: ' .. sock, vim.log.levels.INFO, { title = 'External Editor' })
  end,
  desc = 'Start RPC server for external editor bridge',
})

vim.keymap.set('n', '<leader>v', function()
  local socket = vim.v.servername
  -- Escape backslashes for shell
  socket = socket:gsub('\\', '\\\\')
  local ducky_script = vim.env.DUCKY_SCRIPT or 'C:/Users/mcraf/bin/ducky.ps1'
  if vim.fn.filereadable(ducky_script) ~= 1 then
    vim.notify('ducky.ps1 not found at ' .. ducky_script .. '. Set $DUCKY_SCRIPT or install it.', vim.log.levels.WARN, { title = 'Voice Ducky' })
    return
  end
  local cmd = 'pwsh -NoProfile -ExecutionPolicy Bypass -File "' .. ducky_script .. '" --nvim-socket "' .. socket .. '"'

  if package.loaded['snacks'] then
    -- Use toggle to allow hiding without killing
    Snacks.terminal.toggle(cmd, {
      win = {
        position = 'float',
        border = 'rounded',
        width = 0.8,
        height = 0.8,
        title = ' 🦆 Voice Ducky ',
        title_pos = 'center',
      },
      interactive = true,
      singleton = true, -- Keep one instance running
    })
  else
    vim.cmd('vsplit | terminal ' .. cmd)
  end
end, { desc = 'Voice Ducky' })
