return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "python",
        "json",
        "markdown",
        "tsx"
      },

      highlight = {
        enable = true,
        use_languagetree = true,
      },
      autotag = {
        enable = true,
      },
      indent = { enable = true },
    }
  end,
}
