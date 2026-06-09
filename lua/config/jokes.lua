-- "Jokes" toggle: the fun layer of the dashboard (theme image/gif + music).
--
-- When jokes are OFF nothing renders over the dashboard and no music plays —
-- just the logo and the background, silent. The state is persisted so it sticks
-- across sessions. Toggle with :Jokes or <leader>uj.
local M = {}

local state_file = vim.fn.stdpath("state") .. "/jokes_enabled"
local cached ---@type boolean?

function M.enabled()
  if cached ~= nil then return cached end
  local f = io.open(state_file, "r")
  if not f then
    cached = true -- default ON
    return cached
  end
  local v = f:read("*a") or ""
  f:close()
  cached = v:gsub("%s", "") ~= "0"
  return cached
end

local function persist(on)
  cached = on
  local f = io.open(state_file, "w")
  if f then
    f:write(on and "1" or "0")
    f:close()
  end
end

function M.toggle()
  local on = not M.enabled()
  persist(on)
  if on then
    require("config.dashboard_gif").refresh()
    require("config.music").start()
  else
    require("config.dashboard_gif").hide()
    require("config.music").stop()
  end
  vim.notify("Jokes " .. (on and "ON" or "OFF"), vim.log.levels.INFO)
  return on
end

function M.setup()
  vim.api.nvim_create_user_command("Jokes", function() M.toggle() end,
    { desc = "Toggle dashboard jokes (image/gif + music)" })
  vim.keymap.set("n", "<leader>uj", M.toggle, { desc = "Toggle Jokes (image + music)" })
end

return M
