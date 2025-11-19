return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = {
    "ObsidianQuickSwitch",
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianToday",
  },
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "trabalho",
        path = "/home/dev2/Área de trabalho/trabalho",
      },
    },
    -- Optional, for completion.
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
