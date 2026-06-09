-- Dashboard media overlay, themed.
--   * CHADVIM theme  -> animated giphy.gif (frame-cycled, see below)
--   * bolsonaro theme -> static capitao.jpg
--   * berserk theme   -> nothing (it has its own art pane in snacks)
--
-- Why the GIF isn't just `chafa <gif>` in a terminal:
--   * snacks' dashboard `terminal` section caches output and kills the job on
--     re-render, so a live process freezes.
--   * chafa's own animation either scrolls (frames separated by newlines unless
--     --relative is on) or stalls inside nvim's terminal when it queries the host
--     for pixel size (libvterm doesn't answer), leaving one frame.
--   * kitty's icat graphics don't survive nvim's embedded terminal.
--
-- So we drive it ourselves: pre-render every frame to a fixed-size block of
-- chafa "symbols" text (cached to disk), then cycle the frames on a timer by
-- writing them to a terminal channel with cursor-home. Static images take the
-- same path with a single draw.
local M = {}

local WIDTH, HEIGHT = 44, 20 -- float / render size in cells
local FPS = 14
local GIF_PATH = vim.fn.stdpath("config") .. "/images/giphy.gif"
local IMG_BOLSONARO = vim.fn.stdpath("config") .. "/images/capitao.jpg"
local FRAMES_FILE = vim.fn.stdpath("cache") .. "/chadvim_gif_frames.txt"

-- Reads ~/.config/nvim/colorscheme.lua (managed by the dotfiles theme switcher)
local function active_theme()
  local ok, cs = pcall(dofile, vim.fn.stdpath("config") .. "/colorscheme.lua")
  return ok and cs or ""
end

-- Frames are cached as clean per-frame chafa blocks separated by a form-feed
-- sentinel (0x0c). Each block is the same fixed size, so cycling them never
-- drifts (the old "scrolling" bug came from splitting chafa's animated stream
-- by a guessed line count).
local SENTINEL = "\12\n"

local function load_frames()
  local fd = io.open(FRAMES_FILE, "rb")
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
local function generate(cb)
  if vim.fn.executable("chafa") ~= 1 or vim.fn.executable("ffmpeg") ~= 1 then return end
  if not vim.uv.fs_stat(GIF_PATH) then return end
  local tmp = vim.fn.stdpath("cache") .. "/chadvim_frames_png"
  local gif, out, dir = vim.fn.shellescape(GIF_PATH), vim.fn.shellescape(FRAMES_FILE), vim.fn.shellescape(tmp)
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

-- Build the floating terminal window over the right of the dashboard.
local function make_float(dash_buf)
  local dash_win = vim.fn.bufwinid(dash_buf)
  if dash_win == -1 then return false end
  local W, H = vim.api.nvim_win_get_width(dash_win), vim.api.nvim_win_get_height(dash_win)
  local col = math.min(math.floor(W * 0.54), W - WIDTH - 1)
  local row = math.max(0, math.floor((H - HEIGHT) / 2))

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

local function open_gif(dash_buf)
  local frames = load_frames()
  if not frames then
    generate() -- not ready yet; build cache for next time
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
    -- cursor-home, draw frame, clear anything below: in-place, no scroll.
    pcall(vim.api.nvim_chan_send, chan, "\27[H" .. frames[i] .. "\27[J")
    i = i % #frames + 1
    pcall(vim.api.nvim__redraw, { win = win, valid = false, flush = true })
  end))
end

local function open_static(dash_buf, img_path)
  if vim.fn.executable("chafa") ~= 1 or not vim.uv.fs_stat(img_path) then return end
  if not make_float(dash_buf) then return end

  local cmd = string.format(
    "chafa -f symbols --align center,center --view-size %dx%d %s",
    WIDTH, HEIGHT, vim.fn.shellescape(img_path)
  )
  vim.system({ "sh", "-c", cmd }, { text = false }, function(res)
    if not (res.stdout and #res.stdout > 0) then return end
    vim.schedule(function()
      if not (win and vim.api.nvim_win_is_valid(win) and chan) then return end
      -- terminal channel needs CRLF, chafa emits LF only
      local txt = res.stdout:gsub("\n", "\r\n")
      pcall(vim.api.nvim_chan_send, chan, "\27[H" .. txt .. "\27[J")
      pcall(vim.api.nvim__redraw, { win = win, valid = false, flush = true })
    end)
  end)
end

local function open(dash_buf)
  close()
  local t = active_theme()
  if t == "chadarch-berserk" then
    return -- berserk keeps its own snacks art pane
  elseif t == "chadarch-bolsonaro" then
    open_static(dash_buf, IMG_BOLSONARO)
  else
    open_gif(dash_buf) -- CHADVIM default
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ChadvimDashboardGif", { clear = true })
  -- build the GIF frame cache ahead of time if missing
  if not vim.uv.fs_stat(FRAMES_FILE) then generate() end

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
