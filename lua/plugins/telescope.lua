return {
  "nvim-telescope/telescope.nvim",
  -- cond = not vim.g.vscode,
  cmd = "Telescope",
  opts = {
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top" },
      },
    },
  },
}
