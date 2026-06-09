-- Background music for nvim, driven by mpv via its JSON IPC socket.
--
-- mpv runs as a child job (tied to this session) and we talk to it by writing
-- JSON commands to a unix socket. Music auto-starts when the dashboard opens
-- (fresh nvim, no file args) and is controllable with <leader>m.
--
-- Tracks live in ~/.config/nvim/songs. On a CHADVIM theme it plays the
-- songs/gigaMusic subfolder (e.g. gigamusic.mp3); otherwise the whole songs dir.
local M = {}

local SONGS_DIR = vim.fn.stdpath("config") .. "/songs"
local SOCKET = vim.fn.stdpath("cache") .. "/nvim-mpv.sock"
local DEFAULT_VOLUME = 50
local EXTS = { "mp3", "flac", "ogg", "opus", "m4a", "wav" }

local job ---@type integer?

-- Reads ~/.config/nvim/colorscheme.lua (managed by the dotfiles theme switcher)
local function active_theme()
  local ok, cs = pcall(dofile, vim.fn.stdpath("config") .. "/colorscheme.lua")
  return ok and cs or ""
end

-- Folder mpv plays, picked by the active theme.
local function music_dir()
  local t = active_theme()
  if t == "chadarch-bolsonaro" then return SONGS_DIR .. "/bolsonaro" end
  if t ~= "chadarch-berserk" then return SONGS_DIR .. "/gigaMusic" end -- CHADVIM default
  return SONGS_DIR
end

local function has_tracks(dir)
  if vim.fn.isdirectory(dir) == 0 then return false end
  for _, ext in ipairs(EXTS) do
    if #vim.fn.globpath(dir, "**/*." .. ext, false, true) > 0 then return true end
  end
  return false
end

local function running()
  return vim.uv.fs_stat(SOCKET) ~= nil
end

-- Send a single JSON command to mpv over the IPC socket (fire-and-forget).
local function ipc(command)
  if not running() then return end
  local pipe = vim.uv.new_pipe(false)
  pipe:connect(SOCKET, function(err)
    if err then
      pipe:close()
      return
    end
    pipe:write(vim.json.encode({ command = command }) .. "\n")
    pipe:shutdown(function() pipe:close() end)
  end)
end

function M.start()
  if running() then return end
  if vim.fn.executable("mpv") ~= 1 then
    vim.notify("mpv not installed: sudo apt install mpv", vim.log.levels.WARN)
    return
  end
  local dir = music_dir()
  if not has_tracks(dir) then
    vim.notify("No audio in " .. dir .. " — drop some tracks there", vim.log.levels.INFO)
    return
  end
  job = vim.fn.jobstart({
    "mpv",
    "--no-video",
    "--no-terminal",
    "--idle=once",
    "--loop-playlist=inf",
    "--shuffle",
    "--volume=" .. DEFAULT_VOLUME,
    "--input-ipc-server=" .. SOCKET,
    dir,
  })
end

function M.stop()
  ipc({ "quit" })
  if job then pcall(vim.fn.jobstop, job) end
  job = nil
  pcall(vim.uv.fs_unlink, SOCKET)
end

function M.toggle()
  if running() then M.stop() else M.start() end
end

function M.play_pause() ipc({ "cycle", "pause" }) end
function M.next() ipc({ "playlist-next" }) end
function M.prev() ipc({ "playlist-prev" }) end
function M.vol(delta) ipc({ "add", "volume", delta }) end

function M.setup()
  local map = vim.keymap.set
  map("n", "<leader>mm", M.toggle, { desc = "Music: start/stop" })
  map("n", "<leader>mp", M.play_pause, { desc = "Music: play/pause" })
  map("n", "<leader>mn", M.next, { desc = "Music: next track" })
  map("n", "<leader>mb", M.prev, { desc = "Music: previous track" })
  map("n", "<leader>m=", function() M.vol(5) end, { desc = "Music: volume up" })
  map("n", "<leader>m-", function() M.vol(-5) end, { desc = "Music: volume down" })

  local group = vim.api.nvim_create_augroup("ChadvimMusic", { clear = true })
  -- auto-start when landing on the dashboard (fresh nvim, no file args)
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "SnacksDashboardOpened",
    callback = function()
      if vim.fn.argc() == 0 then M.start() end
    end,
  })
  -- stop music when nvim exits (mpv is a child job, tied to this session)
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function() M.stop() end,
  })
end

return M
