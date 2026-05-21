return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSInstall", "TSInstallInfo", "TSUpdateSync" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "html", "css",
        "typescript", "javascript", "python", "json",
        "markdown", "tsx", "c", "cpp",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
