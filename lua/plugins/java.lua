return {
  -- Java LSP (jdtls) — started per-project from ftplugin/java.lua
  {
    "mfussenegger/nvim-jdtls",
    cond = not vim.g.vscode,
    ft = "java",
    dependencies = { "JavaHello/spring-boot.nvim" },
  },

  -- Spring Boot LSP: application.properties/yml completion, beans, mappings
  {
    "JavaHello/spring-boot.nvim",
    cond = not vim.g.vscode,
    ft = "java",
    config = function()
      require("spring_boot").setup({})
    end,
  },
}
