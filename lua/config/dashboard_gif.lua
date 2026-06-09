-- Dashboard media overlay. Which image/gif shows per theme is configured in
-- lua/config/theme_media.lua; this module just renders whatever it's given:
--   * .gif  -> animated (frames extracted with ffmpeg, rendered with chafa,
--              cached, then cycled in-place on a terminal channel)
--   * other -> static single chafa render
--
-- The animated path avoids chafa's own animation (which scrolls inside nvim's
-- terminal or stalls on its pixel-size query) and snacks' caching terminal
-- section (which freezes a live process). We drive frames ourselves.
local M = {}

local theme_media = require("config.theme_media")

local WIDTH, HEIGHT = 32, 16 -- float / render size in cells (fits below the logo)
local FPS = 14
local SENTINEL = "\12\n"     -- form-feed between cached frames

-- Per-media cache file (so each theme's gif gets its own cache).
local function frames_file(media)
  local key = vim.fn.sha256(media .. ":" .. WIDTH .. "x" .. HEIGHT)
  return vim.fn.stdpath("cache") .. "/chadvim_frames_" .. key .. ".txt"
end

local function load_frames(media)
  local fd = io.open(frames_file(media), "rb")
  if not fd then return nil end
  local data = fd:read("*a")
  fd:close()
  if not data or #data == 0 then return nil end
  local frames = {}
  for _, part in ipairs(vim.split(data, SENTINEL, { plain = true })) do
    if part:match("%S") then
      local lines = vim.split(part, "\n", { plain = true })
      while #lines > 0 and lines[#lines] == "" do table.remove(lines) end
      frames[#frames + 1] = table.concat(lines, "\r\n")
    end
  end
  return #frames > 0 and frames or nil
end

-- Extract every GIF frame with ffmpeg, render each to a fixed-size chafa block,
-- join with the sentinel. Async so it never blocks startup.
local function generate(media, cb)
  if vim.fn.executable("chafa") ~= 1 or vim.fn.executable("ffmpeg") ~= 1 then return end
  if not vim.uv.fs_stat(media) then return end
  local tmp = vim.fn.tempname() .. "_chadvim_frames" -- unique dir, no concurrent clash
  local out = vim.fn.shellescape(frames_file(media))
  local gif, dir = vim.fn.shellescape(media), vim.fn.shellescape(tmp)
  local script = table.concat({
    "set -e",
    "rm -rf " .. dir .. " && mkdir -p " .. dir,
    "ffmpeg -loglevel error -i " .. gif .. " " .. dir .. "/%04d.png",
    ": > " .. out,
    "for f in $(ls " .. dir .. "/*.png | sort); do",
    string.format('  chafa -f symbols --align center,center --view-size %dx%d "$f" >> %s', WIDTH, HEIGHT, out),
    "  printf '\\f\\n' >> " .. out,
    "done",
    "rm -rf " .. dir,
  }, "\n")
  vim.system({ "sh", "-c", script }, { text = false }, function()
    if cb then vim.schedule(cb) end
  end)
end

local win, buf, chan, timer

local function close()
  if timer then pcall(function() timer:stop(); timer:close() end) end
  if win and vim.api.nvim_win_is_valid(win) then pcall(vim.api.nvim_win_close, win, true) end
  if buf and vim.api.nvim_buf_is_valid(buf) then pcall(vim.api.nvim_buf_delete, buf, { force = true }) end
  win, buf, chan, timer = nil, nil, nil, nil
end

-- Window row of the gap reserved in snacks below the header: the first run of
-- >= HEIGHT blank lines that comes *after* the header art. Robust to headers
-- that contain their own blank lines and to top centring padding.
local function gap_row(dash_buf)
  local lines = vim.api.nvim_buf_get_lines(dash_buf, 0, -1, false)
  local seen_content, run_start, run = false, nil, 0
  for idx = 1, #lines do
    if lines[idx]:match("^%s*$") then
      if seen_content then
        if run == 0 then run_start = idx end
        run = run + 1
        if run >= HEIGHT then return run_start - 1 end
      end
    else
      seen_content, run = true, 0
    end
  end
  return run_start and (run_start - 1) or 0
end

-- Floating terminal window, centred horizontally, just below the logo.
local function make_float(dash_buf)
  local dash_win = vim.fn.bufwinid(dash_buf)
  if dash_win == -1 then return false end
  local W = vim.api.nvim_win_get_width(dash_win)
  local col = math.max(0, math.floor((W - WIDTH) / 2))
  local row = gap_row(dash_buf)

  buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].scrollback = 1
  win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    win = dash_win,
    row = row,
    col = col,
    width = WIDTH,
    height = HEIGHT,
    focusable = false,
    style = "minimal",
    zindex = 100,
    border = "none",
    noautocmd = true,
  })
  -- Solid, opaque background so the transparent terminal behind nvim doesn't
  -- bleed through the image's dark cells (bg mode is "transparent"/"blur").
  vim.api.nvim_set_hl(0, "ChadvimDashGifBg", { bg = "#0c0c14" })
  vim.wo[win].winhighlight = "Normal:ChadvimDashGifBg,NormalFloat:ChadvimDashGifBg"
  vim.wo[win].winblend = 0
  chan = vim.api.nvim_open_term(buf, {})
  return true
end

local function open_gif(dash_buf, media)
  local frames = load_frames(media)
  if not frames then
    generate(media) -- not ready yet; build cache for next time
    return
  end
  if not make_float(dash_buf) then return end

  local i = 1
  timer = vim.uv.new_timer()
  timer:start(0, math.floor(1000 / FPS), vim.schedule_wrap(function()
    if not (win and vim.api.nvim_win_is_valid(win) and chan) then
      close()
      return
    end
    pcall(vim.api.nvim_chan_send, chan, "\27[H" .. frames[i] .. "\27[J")
    i = i % #frames + 1
    pcall(vim.api.nvim__redraw, { win = win, valid = false, flush = true })
  end))
end

local function open_static(dash_buf, media)
  if vim.fn.executable("chafa") ~= 1 or not vim.uv.fs_stat(media) then return end
  if not make_float(dash_buf) then return end
  local cmd = string.format(
    "chafa -f symbols --align center,center --view-size %dx%d %s",
    WIDTH, HEIGHT, vim.fn.shellescape(media)
  )
  vim.system({ "sh", "-c", cmd }, { text = false }, function(res)
    if not (res.stdout and #res.stdout > 0) then return end
    vim.schedule(function()
      if not (win and vim.api.nvim_win_is_valid(win) and chan) then return end
      local txt = res.stdout:gsub("\n", "\r\n") -- terminal channel needs CRLF
      pcall(vim.api.nvim_chan_send, chan, "\27[H" .. txt .. "\27[J")
      pcall(vim.api.nvim__redraw, { win = win, valid = false, flush = true })
    end)
  end)
end

local function open(dash_buf)
  close()
  if not require("config.jokes").enabled() then return end -- jokes off: logo only
  local media = theme_media.current().media
  if not media then return end -- theme opted out of a dashboard overlay
  if media:lower():match("%.gif$") then
    open_gif(dash_buf, media)
  else
    open_static(dash_buf, media)
  end
end

-- Hide any current overlay (used by the jokes toggle).
function M.hide() close() end

-- Re-render the overlay on the visible dashboard, if any (used by the toggle).
function M.refresh()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    local b = vim.api.nvim_win_get_buf(w)
    if vim.bo[b].filetype == "snacks_dashboard" then
      open(b)
      return
    end
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ChadvimDashboardGif", { clear = true })
  -- warm the gif cache for the current theme ahead of time
  local media = theme_media.current().media
  if media and media:lower():match("%.gif$") and not vim.uv.fs_stat(frames_file(media)) then
    generate(media)
  end

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "SnacksDashboardOpened",
    callback = function(ev)
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(ev.buf) and vim.fn.bufwinid(ev.buf) ~= -1 then
          open(ev.buf)
        end
      end, 60)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "SnacksDashboardClosed",
    callback = close,
  })
end

return M
