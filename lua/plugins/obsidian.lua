return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  cmd = { "Obsidian" },
  keys = {
    { "<leader>oo", "<cmd>Obsidian quick_switch<CR>", desc = "Obsidian: Open/Switch note" },
    { "<leader>on", "<cmd>Obsidian new<CR>", desc = "Obsidian: New note" },
    { "<leader>os", "<cmd>Obsidian search<CR>", desc = "Obsidian: Search notes" },
    { "<leader>ow", "<cmd>Obsidian workspace<CR>", desc = "Obsidian: Switch vault" },
    { "<leader>ot", "<cmd>Obsidian today<CR>", desc = "Obsidian: Today's daily note" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "trabalho",
        path = "/home/inside-dev1/vault/trabalho",
      },
      {
        name = "work-vault",
        path = "/home/inside-dev1/vault/work-vault",
      },
      {
        name = "obsidian-vault",
        path = "/home/inside-dev1/vault/obsidian-vault",
      },
    },
    -- Use snacks.nvim as the picker (matches the rest of the config).
    picker = {
      name = "snacks.pick",
    },
    -- Optional, for completion.
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
