-- lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Adicione seus autocomandos aqui
-- Exemplo:
-- augroup('MyAutocmds', { clear = true })
-- autocmd('BufWritePre', {
--   group = 'MyAutocmds',
--   pattern = '*',
--   command = 'echo "Escrevendo no buffer..."'
-- })
