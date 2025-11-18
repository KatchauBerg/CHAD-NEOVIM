-- lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Grupo para autocomandos de carregamento e salvamento de tema
augroup('ThemeHandler', { clear = true })

-- Carrega o esquema de cores ao entrar no Neovim
autocmd('VimEnter', {
  group = 'ThemeHandler',
  pattern = '*',
  callback = function()
    -- Carrega o tema salvo
    local status, theme = pcall(require, 'colorscheme')
    if status and theme then
      vim.cmd.colorscheme(theme)
    else
      -- Fallback se o arquivo não existir ou estiver vazio
      vim.cmd.colorscheme('catppuccin')
    end
  end,
})

-- Salva o esquema de cores sempre que for alterado
autocmd('ColorScheme', {
  group = 'ThemeHandler',
  pattern = '*',
  callback = function(args)
    local theme = args.match
    if theme then
      local file = io.open(vim.fn.stdpath('config') .. '/colorscheme.lua', 'w')
      if file then
        file:write('return "' .. theme .. '"')
        file:close()
      end
    end
  end,
})
