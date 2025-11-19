return {
  "nvim-telescope/telescope.nvim",
  -- cond = not vim.g.vscode,
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Telescope: Find Files" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Telescope: Old Files" },
    { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Telescope: Live Grep" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "Telescope: Git Status" },
  },
  opts = {
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top" },
      },
    },
  },
}
