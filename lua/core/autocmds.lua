local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = true,
  },
})

autocmd("CursorHold", {
  group = augroup("DiagnosticFloat", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

local theme_group = augroup('ThemeHandler', { clear = true })
local matugen_group = augroup('MatugenReload', { clear = true })
local bg_group = augroup('BackgroundMode', { clear = true })
local catppuccin_group = augroup('CatppuccinSync', { clear = true })

-- Catppuccin active -> sync kitty terminal colors + swap lualine theme.
-- Other themes -> reset kitty to kitty.conf, restore matugen lualine.
autocmd('ColorScheme', {
  group = catppuccin_group,
  pattern = '*',
  callback = function(args)
    local theme = args.match or ''
    vim.schedule(function()
      pcall(function() require('config.kitty_theme').sync(theme) end)

      local ok, lualine = pcall(require, 'lualine')
      if not ok then return end
      local L = require('config.lualine_opts')
      if theme:match('^catppuccin') then
        lualine.setup(L.opts(L.catppuccin_theme()))
      elseif not theme:match('^chadarch') then
        -- chadarch-* statuslines are owned by chad-line.nvim; leave them alone.
        package.loaded['config.matugen_lualine'] = nil
        lualine.setup(L.opts(require('config.matugen_lualine')))
      end
    end)
  end,
})

-- Re-apply transparency/blur after any colorscheme change
autocmd('ColorScheme', {
  group = bg_group,
  pattern = '*',
  callback = function()
    vim.schedule(function()
      pcall(function() require('config.background').apply() end)
    end)
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
