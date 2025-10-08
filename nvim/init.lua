require "options"
require "mappings"
require "commands"

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = require "plugins"

require("lazy").setup(plugins, require "lazy_config")

vim.cmd "colorscheme hackthebox"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks-dashboard", -- O tipo de arquivo do painel do snacks
  callback = function(args)
    -- Atraso mínimo para garantir que o painel esteja totalmente desenhado
    vim.defer_fn(function()
      require("image").display({
        path = vim.fn.expand("~") .. "/.config/nvim/images/giphy.gif",
        
        -- Posição da imagem na tela (linha e coluna)
        -- !! AJUSTE ESTES VALORES para encaixar no seu layout !!
        row = 8,
        col = 50,
        
        -- Você também pode definir um tamanho máximo
        max_width = 80,
        max_height = 20,
        
        -- Importante: especifica para desenhar no buffer do painel
        bufnr = args.buf,
      })
    end, 10) -- 10ms de atraso
  end,
})
