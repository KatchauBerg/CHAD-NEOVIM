-- chad-line.nvim — statusline temática que segue o colorscheme.
-- Plugin local (repo próprio em ~/chad-line.nvim). Para os temas chadarch
-- aplica a statusline correspondente; para os demais (ex. matugen) não mexe.
return {
  dir = vim.fn.expand "~/chad-line.nvim",
  name = "chad-line.nvim",
  dependencies = { "nvim-lualine/lualine.nvim" },
  event = "VeryLazy",
  opts = {
    follow = true,
    fallback = false, -- não sobrescreve a statusline em temas sem mapeamento
  },
}
