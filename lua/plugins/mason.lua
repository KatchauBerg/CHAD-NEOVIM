return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  cond = not vim.g.vscode,
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "ts_ls", "clangd", "html", "cssls" }
    })
    require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
    })
  end,
}