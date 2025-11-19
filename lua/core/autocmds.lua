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
    local theme_file = vim.fn.stdpath('config') .. '/colorscheme.lua'
    -- Usamos dofile para carregar o arquivo com caminho absoluto
    local status, theme = pcall(dofile, theme_file)
    if status and theme then
      vim.cmd.colorscheme(theme)
    else
      -- Fallback se o arquivo não existir ou falhar ao carregar
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
