return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "NvimTree: Toggle" },
    { "<C-h>", "<cmd> NvimTreeFocus <CR>", desc = "NvimTree: Focus" },
  },
  opts = {}
}
