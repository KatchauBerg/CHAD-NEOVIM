local M = {}

local state_file = vim.fn.stdpath("config") .. "/background.lua"

-- Highlight groups whose bg gets stripped in transparent/blur mode
local GROUPS = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
  "SignColumn", "EndOfBuffer", "LineNr", "CursorLineNr", "CursorLine",
  "StatusLine", "StatusLineNC", "WinSeparator", "VertSplit",
  "TabLine", "TabLineFill", "TabLineSel",
  "Pmenu", "PmenuSbar", "PmenuThumb",
  "MsgArea", "MsgSeparator",
  -- File tree
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeWinSeparator",
  -- Snacks (picker/explorer/dashboard)
  "SnacksNormal", "SnacksNormalNC", "SnacksBackdrop", "SnacksDashboardNormal",
  "SnacksPickerListBorder", "SnacksPickerPreviewBorder", "SnacksPickerInputBorder",
  "SnacksPickerList", "SnacksPickerPreview", "SnacksPickerInput",
  -- Bufferline
  "BufferLineFill", "BufferLineBackground",
  -- Telescope (if used)
  "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal",
  -- Diagnostics
  "DiagnosticVirtualTextError", "DiagnosticVirtualTextWarn",
  "DiagnosticVirtualTextInfo", "DiagnosticVirtualTextHint",
  -- Which-key
  "WhichKeyFloat", "WhichKeyBorder",
}

local VALID = { solid = true, transparent = true, blur = true }

local KITTY_OPTS = {
  solid       = { "background_opacity=1.0",  "background_blur=0"  },
  transparent = { "background_opacity=0.85", "background_blur=0"  },
  blur        = { "background_opacity=0.85", "background_blur=20" },
}

local function kitty_apply(mode)
  if vim.fn.executable("kitty") == 0 then return end
  local opts = KITTY_OPTS[mode]
  if not opts then return end
  local socket = vim.env.KITTY_LISTEN_ON
  if not socket or socket == "" then
    socket = "unix:/tmp/mykitty"
  end
  local cmd = { "kitty", "@", "--to", socket, "load-config" }
  for _, o in ipairs(opts) do
    table.insert(cmd, "-o")
    table.insert(cmd, o)
  end
  pcall(vim.system, cmd, { detach = true })
end

local function read_mode()
  local ok, m = pcall(dofile, state_file)
  if ok and VALID[m] then return m end
  return "solid"
end

local function write_mode(m)
  local f = io.open(state_file, "w")
  if f then
    f:write(string.format('return %q\n', m))
    f:close()
  end
end

function M.apply()
  local mode = read_mode()

  if mode ~= "solid" then
    for _, g in ipairs(GROUPS) do
      pcall(vim.api.nvim_set_hl, 0, g, { bg = "NONE" })
    end
  end

  if mode == "blur" then
    vim.o.winblend = 10
    vim.o.pumblend = 10
  else
    vim.o.winblend = 0
    vim.o.pumblend = 0
  end

  kitty_apply(mode)
end

function M.set(mode)
  if not VALID[mode] then
    vim.notify("Invalid bg mode: " .. tostring(mode) .. " (use solid|transparent|blur)", vim.log.levels.ERROR)
    return
  end
  write_mode(mode)
  -- Reload colorscheme to reset highlights, then re-apply mode
  local theme = vim.g.colors_name
  if theme and theme ~= "" then
    pcall(vim.cmd.colorscheme, theme)
  end
  M.apply()
  vim.notify("Background: " .. mode, vim.log.levels.INFO)
end

function M.current() return read_mode() end

function M.cycle()
  local order = { "solid", "transparent", "blur" }
  local cur = read_mode()
  for i, m in ipairs(order) do
    if m == cur then
      M.set(order[(i % #order) + 1])
      return
    end
  end
  M.set("solid")
end

return M
