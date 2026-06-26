-- YouTube Music: a detached, headless mpv daemon that plays in the background
-- and OUTLIVES nvim/the terminal (unlike the joke music, which is tied to the
-- session). The picker (scripts/ytmusic/ytmusic) loads tracks into the daemon;
-- these maps just drive it over its IPC socket.
--
-- Standalone: `ytmusic` opens the picker, `ytmusic pause|next|prev|stop|vol N`
-- controls it from any terminal.
local M = {}

local SOCKET = (vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache"))
  .. "/ytmusic/mpv.sock"

local function script()
  return vim.fn.stdpath("config") .. "/scripts/ytmusic/ytmusic"
end

-- Send a JSON command to the background daemon (no-op if not running).
-- `sync` pumps the event loop until the write flushes — required at exit, where
-- a fire-and-forget write would be dropped during nvim's teardown.
local function ipc(command, sync)
  if vim.uv.fs_stat(SOCKET) == nil then
    if not sync then vim.notify("YouTube Music não está tocando", vim.log.levels.INFO) end
    return
  end
  local done = false
  local pipe = vim.uv.new_pipe(false)
  pipe:connect(SOCKET, function(err)
    if err then
      pipe:close()
      done = true
      return
    end
    pipe:write(vim.json.encode({ command = command }) .. "\n")
    pipe:shutdown(function()
      pipe:close()
      done = true
    end)
  end)
  if sync then vim.wait(1000, function() return done end) end
end

-- True once this nvim session opened the picker. Used to decide whether to stop
-- the daemon on exit: music started from here dies with nvim; music started
-- standalone (another terminal) is left alone.
M._started_here = false

function M.open()
  M._started_here = true
  Snacks.terminal(script(), { win = { position = "float" } })
end

function M.pause() ipc({ "cycle", "pause" }) end
function M.next() ipc({ "playlist-next" }) end
function M.prev() ipc({ "playlist-prev" }) end
function M.vol(delta) ipc({ "add", "volume", delta }) end
function M.stop()
  ipc({ "quit" }, true)  -- sync: make sure quit lands even during nvim exit
  pcall(vim.uv.fs_unlink, SOCKET)
end

function M.setup()
  vim.api.nvim_create_user_command("YTMusic", M.open,
    { desc = "YouTube Music player (terminal)" })
  vim.api.nvim_create_user_command("YTMusicStop", M.stop,
    { desc = "YouTube Music: stop background daemon" })

  local map = vim.keymap.set
  -- All under <leader>my (no bare <leader>my map, so no which-key timeout clash).
  map("n", "<leader>myo", M.open, { desc = "YT Music: open/search" })
  map("n", "<leader>myp", M.pause, { desc = "YT Music: play/pause" })
  map("n", "<leader>myn", M.next, { desc = "YT Music: next track" })
  map("n", "<leader>myb", M.prev, { desc = "YT Music: previous track" })
  map("n", "<leader>mys", M.stop, { desc = "YT Music: stop" })
  map("n", "<leader>my=", function() M.vol(5) end, { desc = "YT Music: volume up" })
  map("n", "<leader>my-", function() M.vol(-5) end, { desc = "YT Music: volume down" })

  -- Music opened from this nvim stops when nvim closes (closing just the
  -- terminal buffer keeps it playing — only a full quit stops it).
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("ChadvimYTMusic", { clear = true }),
    callback = function()
      if M._started_here then M.stop() end
    end,
  })
end

return M
