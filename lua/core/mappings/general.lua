local map = vim.keymap.set

map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

local function toggle_relative_numbers()
  vim.o.relativenumber = not vim.o.relativenumber
  vim.o.number = not vim.o.number
end

map("n", "<leader>rn", toggle_relative_numbers, { desc = "Toggle Relative Numbers" })

map("n", "<leader>ub", function() require("config.background").cycle() end, { desc = "Cycle Background Mode" })
