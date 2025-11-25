require('core.options')
require('core.mappings')
require('core.commands')
require('core.autocmds')

require('config.lazy')

pcall(vim.cmd.colorscheme, 'matugen')
