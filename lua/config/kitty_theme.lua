-- Sync kitty terminal colors with the active nvim colorscheme.
-- When catppuccin is active -> push catppuccin-mocha palette to kitty via its
-- remote-control socket. Any other theme -> reset kitty to its own kitty.conf.
-- Requires in kitty.conf: `allow_remote_control yes` + `listen_on unix:/tmp/mykitty`.
local M = {}

local CONF = vim.fn.expand("~/.config/kitty/catppuccin-mocha.conf")

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

-- Apply catppuccin palette to all current + future kitty windows.
function M.apply()
  if vim.fn.filereadable(CONF) == 1 then
    kitty({ "-a", "-c", CONF })
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
