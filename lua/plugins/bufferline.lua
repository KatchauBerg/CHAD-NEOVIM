return {
  "akinsho/bufferline.nvim",
  -- cond = not vim.g.vscode,
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
}
