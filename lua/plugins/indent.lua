return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "▏" },
    scope = {
      enabled = true,
      show_start = true,
    },
    exclude = {
      filetypes = { "help", "dashboard", "neo-tree", "alpha" },
    },
  },
}
