-- Shared lualine options builder. Used at startup (lua/plugins/ui.lua) and on
-- every colorscheme switch (lua/core/autocmds.lua) so the bar stays consistent
-- and the theme follows the active colorscheme (catppuccin flavour-aware).
local M = {}

-- Resolve the catppuccin lualine theme name from the active flavour.
-- catppuccin ships flavour-specific themes only (catppuccin-mocha, -latte, ...).
-- `flavour = "auto"` is resolved against vim.o.background.
function M.catppuccin_theme()
  local ok, c = pcall(require, "catppuccin")
  local fl = ok and c.flavour
  if not fl or fl == "auto" then
    fl = (vim.o.background == "light") and "latte" or "mocha"
  end
  return "catppuccin-" .. fl
end

-- Attached LSP client names with an icon (empty when none).
local function lsp_clients()
  local names = {}
  for _, c in pairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
    names[#names + 1] = c.name
  end
  if #names == 0 then return "" end
  return " " .. table.concat(names, ",")
end

-- Nerd Font / powerline glyphs as explicit UTF-8 bytes (Private Use Area).
local CAP_L   = "\238\130\182" -- e0b6  round half-circle, left outer cap
local CAP_R   = "\238\130\180" -- e0b4  round half-circle, right outer cap
local VIM_ICO = "\238\152\171" -- e62b  vim/nvim logo for the mode section
local DOT     = "\226\151\143" -- 25cf  ● filled dot for diagnostics

-- Build the complete lualine opts for a given theme (string name or table).
-- "Bubbles" style: rounded outer caps + icons (see catppuccin showcase).
function M.opts(theme)
  return {
    options = {
      theme = theme,
      component_separators = "",
      section_separators = { left = CAP_R, right = CAP_L },
      globalstatus = true,
    },
    sections = {
      -- left: rounded cap + mode (vim icon)
      lualine_a = {
        { "mode", icon = VIM_ICO, separator = { left = CAP_L }, padding = { left = 1, right = 1 } },
      },
      lualine_b = { "progress", "location" },
      lualine_c = {
        { "diagnostics", symbols = { error = DOT .. " ", warn = DOT .. " ", info = DOT .. " ", hint = DOT .. " " } },
      },
      -- right: lsp, git, filename (with devicon), then rounded cap on filetype
      lualine_x = { lsp_clients, "branch", "diff" },
      lualine_y = {
        { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
        { "filename", padding = { left = 1, right = 1 } },
      },
      lualine_z = {
        { "filetype", separator = { right = CAP_R }, padding = { left = 1, right = 1 } },
      },
    },
  }
end

return M
