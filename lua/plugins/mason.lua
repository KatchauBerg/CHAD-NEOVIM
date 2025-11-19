return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  cond = not vim.g.vscode,
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        -- NOTA: A lista de servidores foi inferida.
        -- Adicione ou remova servidores conforme necessário.
        ensure_installed = { "lua_ls", "pylsp", "tsserver" }
    })
  end,
}