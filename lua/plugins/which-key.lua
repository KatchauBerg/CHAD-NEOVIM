return {
  "folke/which-key.nvim",
  -- cond = not vim.g.vscode,
  event = "VeryLazy",
  opts = {
    defaults = {
      ["<leader>r"] = { name = "+relative numbers" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
