local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- nvimtree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
map("n", "<C-h>", "<cmd> NvimTreeFocus <CR>")

-- telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")

-- bufferline, cycle buffers
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end)


local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col) == " "
end

-- Mapeamento Principal para Snippets e Navegação
map("i", "<Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    -- Se o menu estiver visível, use Tab para selecionar a próxima sugestão
    return vim.fn["coc#_select_confirm"]()
  elseif vim.fn["coc#expandable"]() == 1 then
    -- Se houver um Snippet, use Tab para expandi-lo
    return vim.fn["coc#expand"]()
  elseif check_back_space() then
    -- Se estiver no início da linha ou após um espaço, insere um Tab normal (indentação)
    return "<Tab>"
  else
    -- Caso contrário, insere um Tab normal (indentação)
    return vim.fn["coc#refresh"]()
  end
end, { expr = true, silent = true, desc = "CoC: Navegação/Confirmação/Snippet" })

-- Navegação no menu do CoC (usando Shift+Tab para Voltar)
map("i", "<S-Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#_select_prev"]()
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true, desc = "CoC: Sugestão Anterior" })

-- Mapeamento para confirmar a sugestão com Enter (CR)
-- Isso é necessário para que o CoC saiba o que fazer com a tecla Enter
map("i", "<CR>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    -- Confirma e insere a sugestão selecionada
    return vim.fn["coc#_select_confirm"]()
  else
    -- Comportamento normal do Enter (nova linha)
    return "<CR>"
  end
end, { expr = true, silent = true, desc = "CoC: Confirmação com Enter" })
