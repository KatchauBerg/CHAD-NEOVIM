return {
  -- Mason: LSP/DAP installer
  {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "ts_ls", "clangd", "html", "cssls", "eslint", "intelephense", "asm_lsp" },
      })
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "js-debug-adapter" },
        automatic_installation = true,
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          local opts = { buffer = ev.buf }
          local map = vim.keymap.set
          map("n", "gD", vim.lsp.buf.declaration, opts)
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
          map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          map("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          map("n", "<space>D", vim.lsp.buf.type_definition, opts)
          map("n", "<space>rn", vim.lsp.buf.rename, opts)
        end,
      })

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.enable({ "html", "cssls", "lua_ls", "pylsp", "ts_ls", "clangd", "eslint", "intelephense", "asm_lsp" })
    end,
  },
}
