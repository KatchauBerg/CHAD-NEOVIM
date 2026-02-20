local status, c = pcall(require, 'matugen_colors')

if not status then
  c = {
    background = "#1e1e2e", foreground = "#cdd6f4",
    primary = "#89b4fa", secondary = "#a6e3a1",
    tertiary = "#f9e2af", cursorline = "#313244",
    error = "#f38ba8", warn = "#fab387"
  }
end

local theme = {
  normal = {
    a = { bg = c.primary, fg = c.background, gui = 'bold' },
    b = { bg = c.cursorline, fg = c.primary },
    c = { bg = 'NONE', fg = c.foreground }, -- Fundo transparente no meio
  },
  insert = {
    a = { bg = c.secondary, fg = c.background, gui = 'bold' },
    b = { bg = c.cursorline, fg = c.secondary },
    c = { bg = 'NONE', fg = c.foreground },
  },
  visual = {
    a = { bg = c.tertiary, fg = c.background, gui = 'bold' },
    b = { bg = c.cursorline, fg = c.tertiary },
    c = { bg = 'NONE', fg = c.foreground },
  },
  replace = {
    a = { bg = c.error, fg = c.background, gui = 'bold' },
    b = { bg = c.cursorline, fg = c.error },
    c = { bg = 'NONE', fg = c.foreground },
  },
  command = {
    a = { bg = c.warn, fg = c.background, gui = 'bold' },
    b = { bg = c.cursorline, fg = c.warn },
    c = { bg = 'NONE', fg = c.foreground },
  },
  inactive = {
    a = { bg = 'NONE', fg = c.comment },
    b = { bg = 'NONE', fg = c.comment },
    c = { bg = 'NONE', fg = c.comment },
  },
}

return theme
