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
