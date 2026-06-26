-- All colorschemes lazy-loaded. Only the active one materializes (via vim.cmd.colorscheme in init.lua).
local notVscode = not vim.g.vscode
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha (auto = follows background)
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      term_colors = false, -- kitty colors handled by lua/config/kitty_theme.lua
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
        mini = { enabled = true, indentscope_color = "" },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },
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
