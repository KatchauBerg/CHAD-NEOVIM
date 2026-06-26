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

-- Claude Code terminal: ESC must reach the Claude TUI (cancel prompt / leave menu),
-- so the global <Esc> exit-to-normal map is disabled there. Use <C-q> to enter
-- Normal mode for scrolling/selection instead.
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("ClaudeTermKeys", { clear = true }),
  callback = function(ev)
    if not vim.api.nvim_buf_get_name(ev.buf):match("claude") then
      return
    end
    local o = { buffer = ev.buf }
    -- ESC passes through to Claude
    map("t", "<Esc>", "<Esc>", vim.tbl_extend("force", o, { desc = "Claude: send Esc" }))
    -- Enter Normal mode (scroll/select) without closing Claude
    map("t", "<C-q>", "<C-\\><C-n>", vim.tbl_extend("force", o, { desc = "Claude: Normal mode" }))
  end,
})
