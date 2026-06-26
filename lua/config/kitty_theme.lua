-- Sync kitty terminal colors with the active nvim colorscheme.
-- When catppuccin is active -> push catppuccin-mocha palette to kitty via its
-- remote-control socket. Any other theme -> reset kitty to its own kitty.conf.
-- Requires in kitty.conf: `allow_remote_control yes` + `listen_on unix:/tmp/mykitty`.
local M = {}

-- Resolve the active catppuccin flavour ("auto" -> background) and map to its
-- kitty theme file: ~/.config/kitty/catppuccin-<flavour>.conf
local function conf_for_flavour()
  local theme = require("config.lualine_opts").catppuccin_theme() -- "catppuccin-<flavour>"
  return vim.fn.expand("~/.config/kitty/" .. theme .. ".conf")
end

local function socket()
  -- kitty exports KITTY_LISTEN_ON for child processes; fall back to configured.
  return vim.env.KITTY_LISTEN_ON or "unix:/tmp/mykitty"
end

local function kitty(args)
  if vim.fn.executable("kitty") ~= 1 then
    return
  end
  local cmd = { "kitty", "@", "--to", socket(), "set-colors" }
  vim.list_extend(cmd, args)
  -- async, never block; ignore errors (e.g. not running inside kitty)
  vim.system(cmd, { text = true })
end

-- Apply the active flavour's catppuccin palette to all current + future windows.
function M.apply()
  local conf = conf_for_flavour()
  if vim.fn.filereadable(conf) == 1 then
    kitty({ "-a", "-c", conf })
  end
end

-- Revert kitty to the colors defined in kitty.conf.
function M.reset()
  kitty({ "--reset", "-a", "-c" })
end

-- Decide based on a colorscheme name.
function M.sync(theme)
  theme = theme or vim.g.colors_name or ""
  if theme:match("^catppuccin") then
    M.apply()
  else
    M.reset()
  end
end

return M
