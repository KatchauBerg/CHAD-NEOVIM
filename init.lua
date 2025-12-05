require('core.options')
require('core.mappings')
require('core.commands')
require('core.autocmds')

require('config.lazy')

local theme_file = vim.fn.stdpath('config') .. '/colorscheme.lua'
local status, theme = pcall(dofile, theme_file)
if status and theme then
  pcall(vim.cmd.colorscheme, theme)
else
  pcall(vim.cmd.colorscheme, 'catppuccin')
end
