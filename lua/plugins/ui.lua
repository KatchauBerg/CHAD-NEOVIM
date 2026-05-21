return {
  -- Devicons (lazy: loaded by consumers)
  { "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<cmd> BufferLineCycleNext <CR>", desc = "BufferLine: Next Buffer" },
      { "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>", desc = "BufferLine: Previous Buffer" },
      { "<C-q>", "<cmd> bd <CR>", desc = "BufferLine: Close Buffer" },
    },
    opts = {
      options = {
        themable = true,
        offsets = {
          { filetype = "NvimTree", highlight = "NvimTreeNormal" },
        },
      },
    },
  },

  -- Lualine (uses matugen theme)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local matugen_theme = require("config.matugen_lualine")
      return {
        options = {
          theme = matugen_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "▏" },
      scope = { enabled = true, show_start = true },
      exclude = { filetypes = { "help", "dashboard", "neo-tree", "alpha" } },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>r"] = { name = "+relative numbers" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Smear cursor
  { "sphamba/smear-cursor.nvim", event = "VeryLazy", opts = {} },
}
