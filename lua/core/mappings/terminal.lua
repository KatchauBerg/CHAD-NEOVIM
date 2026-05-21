local map = vim.keymap.set

-- Snacks terminal splits/float
map("n", "<A-h>", function() Snacks.terminal(nil, { win = { position = "bottom" } }) end, { desc = "Terminal: Horizontal Split" })
map("n", "<A-v>", function() Snacks.terminal(nil, { win = { position = "right" } }) end, { desc = "Terminal: Vertical Split" })
map("n", "<A-i>", function() Snacks.terminal() end, { desc = "Terminal: Float" })

-- Terminal mode: exit + window nav
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move Left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move Down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Move Up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move Right" })
