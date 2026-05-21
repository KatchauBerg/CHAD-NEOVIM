return {
  -- Auto-pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Matchup
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
  },

  -- Multicursor (VSCode-style)
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "nvimtools/hydra.nvim" },
    cmd = { "MCstart", "MCclear", "MCUp", "MCDown" },
    opts = {},
    keys = {
      { "<M-Down>", "<cmd>MCDown<cr>", mode = { "n", "i" }, desc = "MC: cursor below" },
      { "<M-Up>",   "<cmd>MCUp<cr>",   mode = { "n", "i" }, desc = "MC: cursor above" },
      { "<C-d>",    "<cmd>MCstart<cr>", mode = { "n", "v" }, desc = "MC: next occurrence" },
      { "<Esc>",    "<cmd>MCclear<cr>", mode = { "n" },     desc = "MC: clear" },
    },
  },

  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("config.rainbow")
    end,
  },

  -- Formatter (format on save)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },

  -- Lazydev (Neovim lua API completion)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "lazydev", group_index = 0 })
    end,
  },
}
