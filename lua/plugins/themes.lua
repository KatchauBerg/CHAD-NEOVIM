-- All colorschemes lazy-loaded. Only the active one materializes (via vim.cmd.colorscheme in init.lua).
local notVscode = not vim.g.vscode
return {
  { "catppuccin/nvim",       name = "catppuccin", lazy = true, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = true, priority = 1000, cond = notVscode },
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = true, priority = 1000, cond = notVscode },
  { "audibleblink/hackthebox.vim", lazy = true, priority = 1000 },

  -- Local theme pack (chadarch-*)
  {
    dir = vim.fn.expand("~/.config/nvim/nvim-themes"),
    name = "chadarch-themes",
    lazy = false,
    priority = 1000,
  },
}
