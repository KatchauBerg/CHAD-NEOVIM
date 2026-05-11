local map = vim.keymap.set

map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>")

map("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "LSP: Format" })

function _G.toggle_relative_numbers()
  vim.o.relativenumber = not vim.o.relativenumber
  vim.o.number = not vim.o.number
end

map("n", "<leader>rn", ":lua _G.toggle_relative_numbers()<CR>", { desc = "Toggle Relative Numbers" })

map("n", "<A-h>", function() Snacks.terminal(nil, { win = { position = "bottom" } }) end, { desc = "Terminal: Horizontal Split" })
map("n", "<A-v>", function() Snacks.terminal(nil, { win = { position = "right" } }) end, { desc = "Terminal: Vertical Split" })
map("n", "<A-i>", function() Snacks.terminal() end, { desc = "Terminal: Float" })

-- exit terminal mode and navigate windows
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move Left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move Down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Move Up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move Right" })

