-- RGB "wave" animation for the snacks dashboard header (CATVIM logo).
-- Strategy (cheap + smooth): assign every header cell to one of K highlight
-- groups by its column (cell index). A timer then rotates a rainbow palette
-- THROUGH those K groups via nvim_set_hl. Extmarks are set once; each tick only
-- redefines K highlights -> vertical rainbow bands sweep horizontally = wave.
local M = {}

local NS = vim.api.nvim_create_namespace("catppuccin_wave")
local K = 28           -- number of phase groups / palette resolution
local FPS = 18
local timer

-- HSV (h in [0,1), s,v in [0,1]) -> "#rrggbb"
local function hsv(h, s, v)
  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)
  local r, g, b
  local m = i % 6
  if m == 0 then r, g, b = v, t, p
  elseif m == 1 then r, g, b = q, v, p
  elseif m == 2 then r, g, b = p, v, t
  elseif m == 3 then r, g, b = p, q, v
  elseif m == 4 then r, g, b = t, p, v
  else r, g, b = v, p, q end
  return string.format("#%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

-- Locate the contiguous block of header lines (rows containing the logo glyphs).
local function header_rows(buf, header_lines)
  local total = vim.api.nvim_buf_line_count(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, total, false)
  -- First non-empty header line text (trim) used as anchor.
  local anchor
  for _, h in ipairs(header_lines) do
    if h:match("%S") then anchor = vim.trim(h); break end
  end
  if not anchor then return nil end
  for r, l in ipairs(lines) do
    if vim.trim(l) == anchor then
      return r - 1, math.min(r - 1 + #header_lines, total)
    end
  end
  return nil
end

local function paint(buf, start_row, end_row)
  vim.api.nvim_buf_clear_namespace(buf, NS, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(buf, start_row, end_row, false)
  for li, line in ipairs(lines) do
    local row = start_row + li - 1
    local pos = vim.str_utf_pos(line) -- 1-based byte offset of each char start
    local n = #pos
    for ci = 1, n do
      local b0 = pos[ci] - 1                       -- 0-based byte start
      local b1 = (pos[ci + 1] or (#line + 1)) - 1  -- 0-based byte end (exclusive)
      local ch = line:sub(b0 + 1, b1)
      if ch:match("%S") then
        local grp = "CatWave" .. ((ci - 1) % K)    -- group by display column
        pcall(vim.api.nvim_buf_set_extmark, buf, NS, row, b0, {
          end_col = b1,
          hl_group = grp,
          priority = 4200, -- beat snacks header hl (default extmark priority 4096)
        })
      end
    end
  end
end

-- Place the per-column extmarks. Idempotent: re-locates header rows each call,
-- so it re-applies after snacks re-renders the dashboard (which wipes extmarks).
function M.start(buf, header_lines)
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then return end
  local rng = { header_rows(buf, header_lines) }
  if not rng[1] then return end
  paint(buf, rng[1], rng[2])

  -- Single shared timer rotates the rainbow palette through the groups.
  if not timer then
    local phase = 0
    timer = vim.uv.new_timer()
    timer:start(0, math.floor(1000 / FPS), vim.schedule_wrap(function()
      for g = 0, K - 1 do
        local h = ((g + phase) % K) / K
        vim.api.nvim_set_hl(0, "CatWave" .. g, { fg = hsv(h, 0.55, 1.0), bold = true })
      end
      phase = (phase + 1) % K
    end))
  end

  -- Stop the timer when the dashboard buffer goes away.
  vim.api.nvim_create_autocmd({ "BufWipeout", "BufHidden" }, {
    buffer = buf,
    once = true,
    callback = function() M.stop() end,
  })
end

function M.stop()
  if timer then
    pcall(function() timer:stop(); timer:close() end)
    timer = nil
  end
end

return M
