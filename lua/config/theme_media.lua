-- Per-theme media registry.
--
-- This is the ONE place to wire a theme to its dashboard image and its music.
-- To add your own theme, drop a new entry in `M.themes` below:
--
--   ["my-colorscheme"] = {
--     media = "images/myart.gif",   -- .gif animates; .jpg/.png/etc is static.
--     music = "songs/mystuff",      -- a folder (plays all) OR a single file.
--   },
--
-- Paths are relative to ~/.config/nvim. Omit `media` for no dashboard overlay
-- (e.g. a theme that already draws its own art). Omit `music` for no autoplay.
-- The theme name must match what colorscheme.lua returns.
local M = {}

local CONFIG = vim.fn.stdpath "config"

M.themes = {
  ["chadarch-bolsonaro"] = { media = "images/capitao.jpg", music = "songs/bolsonaro" },
  ["chadarch-berserk"] = { media = "images/berserk.jpg", music = "songs/berserk" },
}

-- Used when the active theme has no entry above (the CHADVIM default look).
M.default = { media = "images/giphy.gif", music = "songs/gigaMusic" }

-- Reads ~/.config/nvim/colorscheme.lua (managed by the dotfiles theme switcher)
function M.active_theme()
  local ok, cs = pcall(dofile, CONFIG .. "/colorscheme.lua")
  return ok and cs or ""
end

-- Resolved absolute media/music paths for the active theme (nil when disabled).
function M.current()
  local e = M.themes[M.active_theme()] or M.default
  return {
    media = e.media and (CONFIG .. "/" .. e.media) or nil,
    music = e.music and (CONFIG .. "/" .. e.music) or nil,
  }
end

return M
