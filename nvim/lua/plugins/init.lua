return {
  -- DEPENDÊNCIAS - MANTER
  { lazy = true, "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons", opts = {} },

  -- UI/FUNCIONALIDADE NATIVA DO VSCODE - DESATIVAR
  { "echasnovski/mini.statusline", cond = not vim.g.vscode, opts = {} },
  { "lewis6991/gitsigns.nvim", cond = not vim.g.vscode, opts = {} }, -- Recomendado desativar

  -- TEMAS - DESATIVAR
  { "catppuccin/nvim", cond = not vim.g.vscode },
  { "EdenEast/nightfox.nvim", cond = not vim.g.vscode },

  -- UTILIDADES - PODE MANTER
  "audibleblink/hackthebox.vim",

  -- EXPLORADOR DE ARQUIVOS - DESATIVAR
  {
    "nvim-tree/nvim-tree.lua",
    cond = not vim.g.vscode,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {},
  },

  -- TREESITTER - MANTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- BARRA DE ABAS - DESATIVAR
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.vscode,
    opts = require "plugins.configs.bufferline",
  },

  -- TODO O SETUP DE LSP E MASON - DESATIVAR
  {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    cond = not vim.g.vscode,
    config = function()
      require "plugins.configs.masonLsp"
    end
  },
  {
    'neoclide/coc.nvim',
    cond = not vim.g.vscode,
    branch = 'release',
    build = 'npm ci',
    lazy = false,
    config = function()
        -- a config do coc não será executada no vscode
    end,
  },

  -- LINHAS DE INDENTAÇÃO - DESATIVAR
  {
    "nvimdev/indentmini.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- BUSCADOR DE ARQUIVOS - DESATIVAR
  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    cmd = "Telescope",
    opts = require "plugins.configs.telescope",
  },

  -- PLUGINS DE UI/UTILIDADES VISUAIS - DESATIVAR
  {
    "folke/snacks.nvim",
    cond = not vim.g.vscode,
    priority = 1000,
    lazy = false,
    opts = require "plugins.configs.snacks",
    keys = require "plugins.keymaps.snacks",
  },
  {
    "folke/which-key.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = require "plugins.configs.which-key",
    keys= require "plugins.keymaps.which-key",
  },
  {
    "epwalsh/pomo.nvim",
    cond = not vim.g.vscode,
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = { "rcarriga/nvim-notify" },
    opts = require "plugins.configs.pomo",
  },

  -- MÚLTIPLOS CURSORES - DESATIVAR (usar o nativo do VSCode)
  {
    "jake-stewart/multicursor.nvim",
    cond = not vim.g.vscode,
    branch = "1.0",
    config = function()
      -- a config não será executada no vscode
    end
  },

  -- RENDERIZAÇÃO DE IMAGENS - DESATIVAR
  {
    "3rd/image.nvim",
    cond = not vim.g.vscode,
    ft = { "png", "jpg", "jpeg", "gif", "webp" },
    opts = {},
  },

  -- EFEITOS VISUAIS - DESATIVAR
  {
    "sphamba/smear-cursor.nvim",
    cond = not vim.g.vscode,
    opts = {},
  }
}
