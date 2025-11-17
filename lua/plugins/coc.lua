return {
  'neoclide/coc.nvim',
  branch = 'release',
  build = 'npm ci',
  lazy = false,
  config = function()
      -- a config do coc não será executada no vscode
  end,
}
