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

-- Fire-and-forget JSON command to the background daemon (no-op if not running).
local function ipc(command)
  if vim.uv.fs_stat(SOCKET) == nil then
    vim.notify("YouTube Music não está tocando", vim.log.levels.INFO)
    return
  end
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
  ipc({ "quit" })
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
      -- Synchronous stop: the async socket write in M.stop() may not flush
      -- before nvim tears down, so run the blocking CLI path and wait.
      if M._started_here and vim.uv.fs_stat(SOCKET) then
        pcall(function() vim.system({ script(), "stop" }):wait(2000) end)
      end
    end,
  })
end

return M
