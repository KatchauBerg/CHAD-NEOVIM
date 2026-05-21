-- mason, write correct names only
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd "MasonInstall css-lsp html-lsp lua-language-server typescript-language-server stylua prettier"
end, {})

vim.api.nvim_create_user_command("MatugenReload", "colorscheme matugen", {})

-- Background mode: solid / transparent / blur (persisted)
vim.api.nvim_create_user_command("BgMode", function(opts)
  require("config.background").set(opts.args)
end, {
  nargs = 1,
  complete = function() return { "solid", "transparent", "blur" } end,
  desc = "Set background mode (solid|transparent|blur)",
})

vim.api.nvim_create_user_command("BgCycle", function()
  require("config.background").cycle()
end, { desc = "Cycle background mode" })
