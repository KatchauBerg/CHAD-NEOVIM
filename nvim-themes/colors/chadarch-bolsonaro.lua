-- chadarch-bolsonaro: Brazilian flag inspired theme
-- Palette: forest green bg, gold yellow accents, royal blue, white text

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chadarch-bolsonaro"
vim.o.termguicolors = true

-- ─── Palette ──────────────────────────────────────────────────────────────────
local c = {
  bg       = "#003d18",   -- deep forest green (bandeira)
  bg_dark  = "#002a10",   -- darker forest
  bg_0     = "#001a0a",   -- darkest
  surface0 = "#005522",   -- mid green
  surface1 = "#006b2b",   -- lighter surface
  surface2 = "#008033",   -- bright surface
  overlay0 = "#2a7a42",   -- muted green (comments)
  overlay1 = "#4a9a62",   -- mid green-grey (line numbers)
  overlay2 = "#6ab882",   -- lighter overlay

  text     = "#f0f0e8",   -- near white
  subtext0 = "#d0d8c8",   -- dim white
  subtext1 = "#e4ece0",   -- light white
  bone     = "#ffffff",   -- pure white

  -- Main accents (Brazilian flag)
  gold     = "#ffdf00",   -- amarelo bandeira (functions, keys)
  dk_gold  = "#c9a800",   -- dark gold
  br_gold  = "#ffe84d",   -- bright gold (booleans, builtins)
  blue     = "#1a5ab0",   -- azul bandeira clarificado (legível no verde)
  lt_blue  = "#5b9bd5",   -- azul médio (keywords)
  sky      = "#89c4f4",   -- azul claro (specials)
  white    = "#ffffff",   -- branco (strings, constants)
  cream    = "#f5f0dc",   -- off-white

  eclipse  = "#001a0a",   -- selection bg
  none     = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor chrome ────────────────────────────────────────────────────────────
hl("Normal",          { fg = c.text,     bg = c.bg })
hl("NormalNC",        { fg = c.text,     bg = c.bg_dark })
hl("NormalFloat",     { fg = c.text,     bg = c.surface0 })
hl("FloatBorder",     { fg = c.dk_gold,  bg = c.surface0 })
hl("FloatTitle",      { fg = c.gold,     bg = c.surface0, bold = true })
hl("SignColumn",      { fg = c.overlay0, bg = c.bg })
hl("LineNr",          { fg = c.overlay1 })
hl("CursorLineNr",    { fg = c.gold,     bold = true })
hl("CursorLine",      { bg = c.surface0 })
hl("CursorColumn",    { bg = c.surface0 })
hl("ColorColumn",     { bg = c.surface1 })
hl("Folded",          { fg = c.overlay0, bg = c.surface0, italic = true })
hl("FoldColumn",      { fg = c.overlay0, bg = c.bg })
hl("VertSplit",       { fg = c.surface2, bg = c.bg })
hl("WinSeparator",    { fg = c.surface2, bg = c.bg })
hl("StatusLine",      { fg = c.subtext1, bg = c.surface1 })
hl("StatusLineNC",    { fg = c.overlay1, bg = c.surface0 })
hl("TabLine",         { fg = c.overlay1, bg = c.surface1 })
hl("TabLineFill",     { fg = c.overlay0, bg = c.bg_dark })
hl("TabLineSel",      { fg = c.gold,     bg = c.surface0, bold = true })

-- ─── Popup menu ───────────────────────────────────────────────────────────────
hl("Pmenu",           { fg = c.text,     bg = c.surface0 })
hl("PmenuSel",        { fg = c.bg,       bg = c.gold,     bold = true })
hl("PmenuSbar",       { bg = c.surface1 })
hl("PmenuThumb",      { bg = c.dk_gold })
hl("PmenuBorder",     { fg = c.surface2, bg = c.surface0 })

-- ─── Search & selection ───────────────────────────────────────────────────────
hl("Search",          { fg = c.bg,       bg = c.gold })
hl("CurSearch",       { fg = c.bg,       bg = c.br_gold,  bold = true })
hl("IncSearch",       { fg = c.bg,       bg = c.br_gold })
hl("Visual",          { bg = c.eclipse })
hl("VisualNOS",       { bg = c.surface1 })
hl("Substitute",      { fg = c.bg,       bg = c.sky })

-- ─── Messages ─────────────────────────────────────────────────────────────────
hl("ModeMsg",         { fg = c.gold,     bold = true })
hl("MsgArea",         { fg = c.subtext0 })
hl("MoreMsg",         { fg = c.gold })
hl("WarningMsg",      { fg = c.br_gold })
hl("ErrorMsg",        { fg = c.br_gold,  bold = true })
hl("Question",        { fg = c.sky })

-- ─── Diff ─────────────────────────────────────────────────────────────────────
hl("DiffAdd",         { fg = c.gold,     bg = "#002a10" })
hl("DiffChange",      { fg = c.sky,      bg = "#001a30" })
hl("DiffDelete",      { fg = c.br_gold,  bg = "#1a0808" })
hl("DiffText",        { fg = c.sky,      bg = "#002040", bold = true })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
hl("NonText",         { fg = c.overlay2 })
hl("SpecialKey",      { fg = c.overlay0 })
hl("Whitespace",      { fg = c.surface2 })
hl("Directory",       { fg = c.gold,     bold = true })
hl("Title",           { fg = c.gold,     bold = true })
hl("MatchParen",      { fg = c.br_gold,  bg = c.surface1, bold = true })
hl("SpellBad",        { sp = c.br_gold,  undercurl = true })
hl("SpellCap",        { sp = c.sky,      undercurl = true })
hl("SpellLocal",      { sp = c.dk_gold,  undercurl = true })
hl("SpellRare",       { sp = c.sky,      undercurl = true })
hl("EndOfBuffer",     { fg = c.bg })
hl("Conceal",         { fg = c.overlay0 })

-- ─── Syntax (legacy) ──────────────────────────────────────────────────────────
hl("Comment",         { fg = c.overlay0, italic = true })
hl("Constant",        { fg = c.gold })
hl("String",          { fg = c.cream })
hl("Character",       { fg = c.cream })
hl("Number",          { fg = c.br_gold })
hl("Boolean",         { fg = c.br_gold,  bold = true })
hl("Float",           { fg = c.br_gold })
hl("Identifier",      { fg = c.text })
hl("Function",        { fg = c.gold,     bold = true })
hl("Statement",       { fg = c.blue })
hl("Conditional",     { fg = c.lt_blue })
hl("Repeat",          { fg = c.lt_blue })
hl("Label",           { fg = c.sky })
hl("Operator",        { fg = c.subtext0 })
hl("Keyword",         { fg = c.lt_blue,  bold = true })
hl("Exception",       { fg = c.br_gold,  bold = true })
hl("PreProc",         { fg = c.sky })
hl("Include",         { fg = c.sky })
hl("Define",          { fg = c.sky })
hl("Macro",           { fg = c.gold })
hl("PreCondit",       { fg = c.sky })
hl("Type",            { fg = c.gold })
hl("StorageClass",    { fg = c.lt_blue })
hl("Structure",       { fg = c.gold })
hl("Typedef",         { fg = c.gold })
hl("Special",         { fg = c.sky })
hl("SpecialChar",     { fg = c.gold })
hl("Tag",             { fg = c.gold })
hl("Delimiter",       { fg = c.subtext0 })
hl("SpecialComment",  { fg = c.overlay2, italic = true })
hl("Debug",           { fg = c.br_gold })
hl("Underlined",      { underline = true })
hl("Ignore",          { fg = c.overlay0 })
hl("Error",           { fg = c.br_gold,  bold = true, underline = true })
hl("Todo",            { fg = c.bg,       bg = c.gold, bold = true })

-- ─── Treesitter ───────────────────────────────────────────────────────────────
hl("@variable",              { fg = c.text })
hl("@variable.builtin",      { fg = c.br_gold,  italic = true })
hl("@variable.parameter",    { fg = c.subtext1 })
hl("@variable.member",       { fg = c.subtext0 })

hl("@constant",              { fg = c.gold })
hl("@constant.builtin",      { fg = c.gold,     bold = true })
hl("@constant.macro",        { fg = c.br_gold })

hl("@module",                { fg = c.gold,     bold = true })
hl("@label",                 { fg = c.sky })

hl("@string",                { fg = c.cream })
hl("@string.escape",         { fg = c.br_gold })
hl("@string.special",        { fg = c.br_gold })
hl("@string.regex",          { fg = c.br_gold })

hl("@character",             { fg = c.cream })
hl("@number",                { fg = c.br_gold })
hl("@float",                 { fg = c.br_gold })
hl("@boolean",               { fg = c.br_gold,  bold = true })

hl("@function",              { fg = c.gold,     bold = true })
hl("@function.builtin",      { fg = c.gold,     italic = true })
hl("@function.call",         { fg = c.gold })
hl("@function.macro",        { fg = c.br_gold })
hl("@function.method",       { fg = c.gold,     bold = true })
hl("@function.method.call",  { fg = c.gold })

hl("@constructor",           { fg = c.br_gold })
hl("@operator",              { fg = c.subtext0 })

hl("@keyword",               { fg = c.lt_blue,  bold = true })
hl("@keyword.function",      { fg = c.lt_blue,  bold = true })
hl("@keyword.operator",      { fg = c.subtext0 })
hl("@keyword.return",        { fg = c.br_gold,  bold = true })
hl("@keyword.import",        { fg = c.sky })
hl("@keyword.conditional",   { fg = c.lt_blue })
hl("@keyword.repeat",        { fg = c.lt_blue })
hl("@keyword.exception",     { fg = c.br_gold,  bold = true })

hl("@type",                  { fg = c.gold })
hl("@type.builtin",          { fg = c.gold,     italic = true })
hl("@type.definition",       { fg = c.gold })

hl("@attribute",             { fg = c.sky })
hl("@property",              { fg = c.subtext0 })

hl("@punctuation",           { fg = c.subtext0 })
hl("@punctuation.bracket",   { fg = c.subtext0 })
hl("@punctuation.delimiter", { fg = c.subtext0 })
hl("@punctuation.special",   { fg = c.br_gold })

hl("@comment",               { fg = c.overlay0, italic = true })
hl("@comment.todo",          { fg = c.bg,       bg = c.gold,    bold = true })
hl("@comment.note",          { fg = c.bg,       bg = c.sky,     bold = true })
hl("@comment.warning",       { fg = c.bg,       bg = c.br_gold, bold = true })
hl("@comment.error",         { fg = c.bg,       bg = c.br_gold, bold = true })

hl("@tag",                   { fg = c.gold })
hl("@tag.attribute",         { fg = c.br_gold })
hl("@tag.delimiter",         { fg = c.subtext0 })

hl("@markup.heading",        { fg = c.gold,     bold = true })
hl("@markup.link",           { fg = c.sky,      underline = true })
hl("@markup.link.url",       { fg = c.cream,    underline = true })
hl("@markup.raw",            { fg = c.br_gold })
hl("@markup.italic",         { fg = c.subtext1, italic = true })
hl("@markup.strong",         { fg = c.bone,     bold = true })
hl("@markup.list",           { fg = c.gold })

-- ─── LSP semantic tokens ──────────────────────────────────────────────────────
hl("@lsp.type.class",        { link = "@type" })
hl("@lsp.type.enum",         { link = "@type" })
hl("@lsp.type.function",     { link = "@function" })
hl("@lsp.type.interface",    { link = "@type" })
hl("@lsp.type.keyword",      { link = "@keyword" })
hl("@lsp.type.method",       { link = "@function.method" })
hl("@lsp.type.namespace",    { link = "@module" })
hl("@lsp.type.parameter",    { link = "@variable.parameter" })
hl("@lsp.type.property",     { link = "@property" })
hl("@lsp.type.string",       { link = "@string" })
hl("@lsp.type.struct",       { link = "@type" })
hl("@lsp.type.type",         { link = "@type" })
hl("@lsp.type.variable",     { link = "@variable" })

-- ─── Diagnostics ──────────────────────────────────────────────────────────────
hl("DiagnosticError",              { fg = c.br_gold })
hl("DiagnosticWarn",               { fg = c.gold })
hl("DiagnosticInfo",               { fg = c.sky })
hl("DiagnosticHint",               { fg = c.overlay2 })
hl("DiagnosticOk",                 { fg = c.gold })
hl("DiagnosticUnderlineError",     { sp = c.br_gold,  undercurl = true })
hl("DiagnosticUnderlineWarn",      { sp = c.gold,     undercurl = true })
hl("DiagnosticUnderlineInfo",      { sp = c.sky,      undercurl = true })
hl("DiagnosticUnderlineHint",      { sp = c.overlay2, undercurl = true })
hl("DiagnosticVirtualTextError",   { fg = c.dk_gold,  italic = true })
hl("DiagnosticVirtualTextWarn",    { fg = c.dk_gold,  italic = true })
hl("DiagnosticVirtualTextInfo",    { fg = c.overlay1, italic = true })
hl("DiagnosticVirtualTextHint",    { fg = c.overlay0, italic = true })
hl("LspReferenceText",             { bg = c.surface1 })
hl("LspReferenceRead",             { bg = c.surface1 })
hl("LspReferenceWrite",            { bg = c.surface2 })
hl("LspSignatureActiveParameter",  { fg = c.gold,     bold = true })
hl("LspInfoBorder",                { fg = c.surface2 })

-- ─── Plugins ──────────────────────────────────────────────────────────────────

-- gitsigns
hl("GitSignsAdd",                  { fg = c.gold })
hl("GitSignsChange",               { fg = c.sky })
hl("GitSignsDelete",               { fg = c.br_gold })

-- nvim-tree
hl("NvimTreeNormal",               { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeNormalNC",             { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeRootFolder",           { fg = c.gold,     bold = true })
hl("NvimTreeFolderName",           { fg = c.subtext1 })
hl("NvimTreeOpenedFolderName",     { fg = c.gold,     bold = true })
hl("NvimTreeFolderIcon",           { fg = c.br_gold })
hl("NvimTreeFileIcon",             { fg = c.overlay1 })
hl("NvimTreeExecFile",             { fg = c.br_gold,  bold = true })
hl("NvimTreeGitNew",               { fg = c.gold })
hl("NvimTreeGitDirty",             { fg = c.sky })
hl("NvimTreeGitDeleted",           { fg = c.br_gold })
hl("NvimTreeSpecialFile",          { fg = c.sky })
hl("NvimTreeIndentMarker",         { fg = c.surface2 })
hl("NvimTreeWinSeparator",         { fg = c.surface2, bg = c.bg_dark })
hl("NvimTreeCursorLine",           { bg = c.surface0 })
hl("NvimTreeSymlink",              { fg = c.sky })
hl("NvimTreeImageFile",            { fg = c.gold })

-- Telescope
hl("TelescopeNormal",              { fg = c.text,     bg = c.surface0 })
hl("TelescopeBorder",              { fg = c.dk_gold,  bg = c.surface0 })
hl("TelescopePromptNormal",        { fg = c.text,     bg = c.surface1 })
hl("TelescopePromptBorder",        { fg = c.gold,     bg = c.surface1 })
hl("TelescopePromptTitle",         { fg = c.bg,       bg = c.gold,     bold = true })
hl("TelescopePreviewTitle",        { fg = c.bg,       bg = c.br_gold,  bold = true })
hl("TelescopeResultsTitle",        { fg = c.dk_gold,  bg = c.surface0 })
hl("TelescopeMatching",            { fg = c.gold,     bold = true })
hl("TelescopeSelection",           { fg = c.bone,     bg = c.eclipse })
hl("TelescopePromptPrefix",        { fg = c.gold })
hl("TelescopeMultiSelection",      { fg = c.br_gold })

-- bufferline
hl("BufferLineFill",               { bg = c.bg_dark })
hl("BufferLineBackground",         { fg = c.overlay1, bg = c.surface1 })
hl("BufferLineSelected",           { fg = c.bone,     bg = c.bg,       bold = true })
hl("BufferLineSelectedIndicator",  { fg = c.gold,     bg = c.bg })
hl("BufferLineModified",           { fg = c.br_gold,  bg = c.surface1 })
hl("BufferLineModifiedSelected",   { fg = c.br_gold,  bg = c.bg })
hl("BufferLineSeparator",          { fg = c.bg_dark,  bg = c.surface1 })

-- which-key
hl("WhichKey",                     { fg = c.gold })
hl("WhichKeyDesc",                 { fg = c.subtext1 })
hl("WhichKeyGroup",                { fg = c.lt_blue,  bold = true })
hl("WhichKeySeparator",            { fg = c.overlay0 })
hl("WhichKeyBorder",               { fg = c.surface2 })
hl("WhichKeyNormal",               { bg = c.surface0 })

-- indent-blankline / mini.indentscope
hl("IblIndent",                    { fg = c.surface1 })
hl("IblScope",                     { fg = c.dk_gold })
hl("MiniIndentscopeSymbol",        { fg = c.dk_gold })

-- Snacks (dashboard)
hl("SnacksDashboardHeader",        { fg = c.gold,     bold = true })
hl("SnacksDashboardKey",           { fg = c.br_gold })
hl("SnacksDashboardDesc",          { fg = c.subtext0 })
hl("SnacksDashboardIcon",          { fg = c.gold })
hl("SnacksDashboardTitle",         { fg = c.br_gold,  bold = true })
hl("SnacksDashboardFooter",        { fg = c.overlay1, italic = true })

-- toggleterm
hl("ToggleTerm1FloatBorder",       { fg = c.dk_gold,  bg = c.surface0 })
hl("ToggleTermNormal",             { fg = c.text,     bg = c.surface0 })

-- coc.nvim
hl("CocFloating",                  { link = "NormalFloat" })
hl("CocMenuSel",                   { fg = c.bg,       bg = c.gold,     bold = true })
hl("CocSearch",                    { fg = c.gold,     bold = true })
hl("CocErrorSign",                 { fg = c.br_gold })
hl("CocWarningSign",               { fg = c.gold })
hl("CocInfoSign",                  { fg = c.sky })
hl("CocHintSign",                  { fg = c.overlay2 })
hl("CocErrorHighlight",            { sp = c.br_gold,  undercurl = true })
hl("CocWarningHighlight",          { sp = c.gold,     undercurl = true })
hl("CocHighlightText",             { bg = c.surface1 })
hl("CocCodeLens",                  { fg = c.overlay0, italic = true })
