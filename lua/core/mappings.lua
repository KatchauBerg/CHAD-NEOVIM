local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end)

-- Toggle function for relative numbers
function _G.toggle_relative_numbers()
  vim.o.relativenumber = not vim.o.relativenumber
  vim.o.number = not vim.o.number
end

-- Mapping to toggle relative numbers
map("n", "<leader>rn", ":lua _G.toggle_relative_numbers()<CR>", { desc = "Toggle Relative Numbers" })


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

vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-n>", function()
  return vim.fn
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-p>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

