local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Cria os grupos de autocomando
local theme_group = augroup('ThemeHandler', { clear = true })
local matugen_group = augroup('MatugenReload', { clear = true })

-- 1. Carrega o esquema de cores salvo ao entrar no Neovim
autocmd('VimEnter', {
  group = theme_group,
  pattern = '*',
  callback = function()
    local theme_file = vim.fn.stdpath('config') .. '/colorscheme.lua'
    -- Usamos dofile para carregar o arquivo com caminho absoluto
    local status, theme = pcall(dofile, theme_file)
    if status and theme then
      -- Tenta carregar o tema salvo. Se falhar (ex: erro no matugen), cai no catch
      local ok = pcall(vim.cmd.colorscheme, theme)
      if not ok then
        vim.cmd.colorscheme('catppuccin')
      end
    else
      -- Fallback se o arquivo de save não existir
      vim.cmd.colorscheme('catppuccin')
    end
  end,
})

-- 2. Salva o nome do esquema de cores sempre que ele for alterado
autocmd('ColorScheme', {
  group = theme_group,
  pattern = '*',
  callback = function(args)
    local theme = args.match
    if theme then
      -- Evita salvar se o tema for "none" ou vazio
      if theme == "none" or theme == "" then return end

      local file = io.open(vim.fn.stdpath('config') .. '/colorscheme.lua', 'w')
      if file then
        file:write('return "' .. theme .. '"')
        file:close()
      end
    end
  end,
}) -- <--- O erro estava aqui (faltava fechar este parênteses)

-- 3. Listener do Matugen (Escuta o sinal do terminal)
autocmd("Signal", {
  pattern = "SIGUSR1",
  group = matugen_group,
  callback = function()
    vim.schedule(function()
      -- 1. Limpa o cache das cores antigas
      package.loaded['matugen_colors'] = nil
      package.loaded['config.matugen_lualine'] = nil -- Limpa o cache do tema da statusline
      
      -- 2. Recarrega o colorscheme principal
      vim.cmd.colorscheme('matugen')
      
      -- 3. Recarrega o Lualine com as cores novas
      local status_ok, lualine = pcall(require, "lualine")
      if status_ok then
          local new_theme = require("config.matugen_lualine")
          lualine.setup({ options = { theme = new_theme } })
      end

      print("🎨 Matugen: Cores e Statusline atualizadas!")
    end)
  end,
})
