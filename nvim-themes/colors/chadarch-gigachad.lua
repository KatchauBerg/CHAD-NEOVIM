-- chadarch-gigachad: monochrome marble inspired by the GigaChad
-- Palette: black-and-white sculpture — obsidian bg, marble/platinum text,
-- chrome greys, one cold ice-blue accent for focus. High contrast. Sigma.
-- Standalone theme — not tied to any dotfiles system theme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chadarch-gigachad"
vim.o.termguicolors = true

-- ─── Palette ──────────────────────────────────────────────────────────────────
-- Background: obsidian black, faint cool tint (like a studio backdrop)
-- Text: marble / bone white — the chiseled statue
-- Greys: chrome and steel, ascending brightness
-- Ice: one cold blue accent — the gaze. Used for focus, flow, glory.

local c = {
  bg       = "#0a0b0d",   -- obsidian (cool near-black)
  bg_dark  = "#060708",   -- darker void
  bg_0     = "#000000",   -- pure black
  surface0 = "#14161a",   -- charcoal
  surface1 = "#1d2025",   -- gunmetal
  surface2 = "#2a2e35",   -- slate

  overlay0 = "#4c525c",   -- dim steel (comments)
  overlay1 = "#6b727d",   -- mid steel (line numbers)
  overlay2 = "#8d949e",   -- light steel

  text     = "#dfe2e6",   -- marble
  subtext0 = "#b4b9c0",   -- dim marble
  subtext1 = "#cdd1d7",   -- light marble
  bone     = "#f4f6f8",   -- bone white (brightest)

  -- Accents (monochrome with a single cold accent — the gaze)
  platinum = "#f4f6f8",   -- brightest marble (functions — glory)
  silver   = "#c6ccd3",   -- silver (types, constants)
  chrome    = "#aab1b9",  -- chrome (strings)
  ice      = "#8fb6d4",   -- cold ice blue (keywords, focus)
  br_ice   = "#aed0ea",   -- bright ice (booleans, builtins, return)
  dk_ice   = "#4f6f88",   -- dim ice (borders, subtle)
  steel    = "#7f8893",   -- steel (operators, punctuation)
  shadow   = "#1a2430",   -- ice-tinted shadow (selection bg)

  none     = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor chrome ────────────────────────────────────────────────────────────
hl("Normal",          { fg = c.text,     bg = c.bg })
hl("NormalNC",        { fg = c.text,     bg = c.bg_dark })
hl("NormalFloat",     { fg = c.text,     bg = c.surface0 })
hl("FloatBorder",     { fg = c.dk_ice,   bg = c.surface0 })
hl("FloatTitle",      { fg = c.platinum, bg = c.surface0, bold = true })
hl("SignColumn",      { fg = c.overlay0, bg = c.bg })
hl("LineNr",          { fg = c.overlay1 })
hl("CursorLineNr",    { fg = c.bone,     bold = true })
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
hl("TabLineSel",      { fg = c.bone,     bg = c.surface0, bold = true })

-- ─── Popup menu ───────────────────────────────────────────────────────────────
hl("Pmenu",           { fg = c.text,     bg = c.surface0 })
hl("PmenuSel",        { fg = c.bg,       bg = c.ice,      bold = true })
hl("PmenuSbar",       { bg = c.surface1 })
hl("PmenuThumb",      { bg = c.overlay1 })
hl("PmenuBorder",     { fg = c.surface2, bg = c.surface0 })

-- ─── Search & selection ───────────────────────────────────────────────────────
hl("Search",          { fg = c.bg,       bg = c.silver })
hl("CurSearch",       { fg = c.bg,       bg = c.br_ice,   bold = true })
hl("IncSearch",       { fg = c.bg,       bg = c.br_ice })
hl("Visual",          { bg = c.shadow })
hl("VisualNOS",       { bg = c.surface1 })
hl("Substitute",      { fg = c.bg,       bg = c.ice })

-- ─── Messages ─────────────────────────────────────────────────────────────────
hl("ModeMsg",         { fg = c.bone,     bold = true })
hl("MsgArea",         { fg = c.subtext0 })
hl("MoreMsg",         { fg = c.ice })
hl("WarningMsg",      { fg = c.silver })
hl("ErrorMsg",        { fg = c.br_ice,   bold = true })
hl("Question",        { fg = c.ice })

-- ─── Diff ─────────────────────────────────────────────────────────────────────
hl("DiffAdd",         { fg = c.bone,     bg = "#16201b" })
hl("DiffChange",      { fg = c.silver,   bg = "#161a20" })
hl("DiffDelete",      { fg = c.overlay1, bg = "#1c1416" })
hl("DiffText",        { fg = c.br_ice,   bg = "#1a2330", bold = true })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
hl("NonText",         { fg = c.overlay2 })
hl("SpecialKey",      { fg = c.overlay0 })
hl("Whitespace",      { fg = c.surface2 })
hl("Directory",       { fg = c.bone,     bold = true })
hl("Title",           { fg = c.bone,     bold = true })
hl("MatchParen",      { fg = c.br_ice,   bg = c.surface1, bold = true })
hl("SpellBad",        { sp = c.br_ice,   undercurl = true })
hl("SpellCap",        { sp = c.silver,   undercurl = true })
hl("SpellLocal",      { sp = c.steel,    undercurl = true })
hl("SpellRare",       { sp = c.dk_ice,   undercurl = true })
hl("EndOfBuffer",     { fg = c.bg })
hl("Conceal",         { fg = c.overlay0 })

-- ─── Syntax (legacy) ──────────────────────────────────────────────────────────
hl("Comment",         { fg = c.overlay0, italic = true })
hl("Constant",        { fg = c.silver })
hl("String",          { fg = c.chrome })
hl("Character",       { fg = c.chrome })
hl("Number",          { fg = c.silver })
hl("Boolean",         { fg = c.br_ice,   bold = true })
hl("Float",           { fg = c.silver })
hl("Identifier",      { fg = c.text })
hl("Function",        { fg = c.platinum, bold = true })
hl("Statement",       { fg = c.ice })
hl("Conditional",     { fg = c.ice })
hl("Repeat",          { fg = c.ice })
hl("Label",           { fg = c.br_ice })
hl("Operator",        { fg = c.steel })
hl("Keyword",         { fg = c.ice,      bold = true })
hl("Exception",       { fg = c.br_ice,   bold = true })
hl("PreProc",         { fg = c.br_ice })
hl("Include",         { fg = c.br_ice })
hl("Define",          { fg = c.br_ice })
hl("Macro",           { fg = c.silver })
hl("PreCondit",       { fg = c.br_ice })
hl("Type",            { fg = c.silver })
hl("StorageClass",    { fg = c.ice })
hl("Structure",       { fg = c.silver })
hl("Typedef",         { fg = c.silver })
hl("Special",         { fg = c.br_ice })
hl("SpecialChar",     { fg = c.silver })
hl("Tag",             { fg = c.platinum })
hl("Delimiter",       { fg = c.steel })
hl("SpecialComment",  { fg = c.overlay2, italic = true })
hl("Debug",           { fg = c.br_ice })
hl("Underlined",      { underline = true })
hl("Ignore",          { fg = c.overlay0 })
hl("Error",           { fg = c.br_ice,   bold = true, underline = true })
hl("Todo",            { fg = c.bg,       bg = c.silver, bold = true })

-- ─── Treesitter ───────────────────────────────────────────────────────────────
hl("@variable",              { fg = c.text })
hl("@variable.builtin",      { fg = c.br_ice,   italic = true })
hl("@variable.parameter",    { fg = c.subtext1 })
hl("@variable.member",       { fg = c.subtext0 })

hl("@constant",              { fg = c.silver })
hl("@constant.builtin",      { fg = c.silver,   bold = true })
hl("@constant.macro",        { fg = c.silver })

hl("@module",                { fg = c.silver,   bold = true })
hl("@label",                 { fg = c.br_ice })

hl("@string",                { fg = c.chrome })
hl("@string.escape",         { fg = c.br_ice })
hl("@string.special",        { fg = c.br_ice })
hl("@string.regex",          { fg = c.br_ice })

hl("@character",             { fg = c.chrome })
hl("@number",                { fg = c.silver })
hl("@float",                 { fg = c.silver })
hl("@boolean",               { fg = c.br_ice,   bold = true })

hl("@function",              { fg = c.platinum, bold = true })
hl("@function.builtin",      { fg = c.platinum, italic = true })
hl("@function.call",         { fg = c.bone })
hl("@function.macro",        { fg = c.silver })
hl("@function.method",       { fg = c.platinum, bold = true })
hl("@function.method.call",  { fg = c.bone })

hl("@constructor",           { fg = c.silver })
hl("@operator",              { fg = c.steel })

hl("@keyword",               { fg = c.ice,      bold = true })
hl("@keyword.function",      { fg = c.ice,      bold = true })
hl("@keyword.operator",      { fg = c.steel })
hl("@keyword.return",        { fg = c.br_ice,   bold = true })
hl("@keyword.import",        { fg = c.br_ice })
hl("@keyword.conditional",   { fg = c.ice })
hl("@keyword.repeat",        { fg = c.ice })
hl("@keyword.exception",     { fg = c.br_ice,   bold = true })

hl("@type",                  { fg = c.silver })
hl("@type.builtin",          { fg = c.silver,   italic = true })
hl("@type.definition",       { fg = c.silver })

hl("@attribute",             { fg = c.br_ice })
hl("@property",              { fg = c.subtext0 })

hl("@punctuation",           { fg = c.steel })
hl("@punctuation.bracket",   { fg = c.steel })
hl("@punctuation.delimiter", { fg = c.steel })
hl("@punctuation.special",   { fg = c.br_ice })

hl("@comment",               { fg = c.overlay0, italic = true })
hl("@comment.todo",          { fg = c.bg,       bg = c.silver,  bold = true })
hl("@comment.note",          { fg = c.bg,       bg = c.ice,     bold = true })
hl("@comment.warning",       { fg = c.bg,       bg = c.bone,    bold = true })
hl("@comment.error",         { fg = c.bg,       bg = c.br_ice,  bold = true })

hl("@tag",                   { fg = c.platinum })
hl("@tag.attribute",         { fg = c.silver })
hl("@tag.delimiter",         { fg = c.steel })

hl("@markup.heading",        { fg = c.bone,     bold = true })
hl("@markup.link",           { fg = c.ice,      underline = true })
hl("@markup.link.url",       { fg = c.chrome,   underline = true })
hl("@markup.raw",            { fg = c.silver })
hl("@markup.italic",         { fg = c.subtext1, italic = true })
hl("@markup.strong",         { fg = c.bone,     bold = true })
hl("@markup.list",           { fg = c.ice })

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
hl("DiagnosticError",              { fg = c.br_ice })
hl("DiagnosticWarn",               { fg = c.silver })
hl("DiagnosticInfo",               { fg = c.ice })
hl("DiagnosticHint",               { fg = c.overlay2 })
hl("DiagnosticOk",                 { fg = c.bone })
hl("DiagnosticUnderlineError",     { sp = c.br_ice,   undercurl = true })
hl("DiagnosticUnderlineWarn",      { sp = c.silver,   undercurl = true })
hl("DiagnosticUnderlineInfo",      { sp = c.ice,      undercurl = true })
hl("DiagnosticUnderlineHint",      { sp = c.overlay2, undercurl = true })
hl("DiagnosticVirtualTextError",   { fg = c.dk_ice,   italic = true })
hl("DiagnosticVirtualTextWarn",    { fg = c.steel,    italic = true })
hl("DiagnosticVirtualTextInfo",    { fg = c.overlay1, italic = true })
hl("DiagnosticVirtualTextHint",    { fg = c.overlay0, italic = true })
hl("LspReferenceText",             { bg = c.surface1 })
hl("LspReferenceRead",             { bg = c.surface1 })
hl("LspReferenceWrite",            { bg = c.surface2 })
hl("LspSignatureActiveParameter",  { fg = c.bone,     bold = true })
hl("LspInfoBorder",                { fg = c.surface2 })

-- ─── Plugins ──────────────────────────────────────────────────────────────────

-- gitsigns
hl("GitSignsAdd",                  { fg = c.bone })
hl("GitSignsChange",               { fg = c.silver })
hl("GitSignsDelete",               { fg = c.overlay1 })

-- nvim-tree
hl("NvimTreeNormal",               { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeNormalNC",             { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeRootFolder",           { fg = c.bone,     bold = true })
hl("NvimTreeFolderName",           { fg = c.subtext1 })
hl("NvimTreeOpenedFolderName",     { fg = c.bone,     bold = true })
hl("NvimTreeFolderIcon",           { fg = c.ice })
hl("NvimTreeFileIcon",             { fg = c.overlay1 })
hl("NvimTreeExecFile",             { fg = c.br_ice,   bold = true })
hl("NvimTreeGitNew",               { fg = c.bone })
hl("NvimTreeGitDirty",             { fg = c.silver })
hl("NvimTreeGitDeleted",           { fg = c.overlay1 })
hl("NvimTreeSpecialFile",          { fg = c.ice })
hl("NvimTreeIndentMarker",         { fg = c.surface2 })
hl("NvimTreeWinSeparator",         { fg = c.surface2, bg = c.bg_dark })
hl("NvimTreeCursorLine",           { bg = c.surface0 })
hl("NvimTreeSymlink",              { fg = c.ice })
hl("NvimTreeImageFile",            { fg = c.silver })

-- Telescope
hl("TelescopeNormal",              { fg = c.text,     bg = c.surface0 })
hl("TelescopeBorder",              { fg = c.dk_ice,   bg = c.surface0 })
hl("TelescopePromptNormal",        { fg = c.text,     bg = c.surface1 })
hl("TelescopePromptBorder",        { fg = c.ice,      bg = c.surface1 })
hl("TelescopePromptTitle",         { fg = c.bg,       bg = c.ice,      bold = true })
hl("TelescopePreviewTitle",        { fg = c.bg,       bg = c.bone,     bold = true })
hl("TelescopeResultsTitle",        { fg = c.dk_ice,   bg = c.surface0 })
hl("TelescopeMatching",            { fg = c.bone,     bold = true })
hl("TelescopeSelection",           { fg = c.bone,     bg = c.shadow })
hl("TelescopePromptPrefix",        { fg = c.ice })
hl("TelescopeMultiSelection",      { fg = c.silver })

-- bufferline
hl("BufferLineFill",               { bg = c.bg_dark })
hl("BufferLineBackground",         { fg = c.overlay1, bg = c.surface1 })
hl("BufferLineBufferSelected",     { fg = c.bone,     bg = c.bg,       bold = true })
hl("BufferLineIndicatorSelected",  { fg = c.ice,      bg = c.bg })
hl("BufferLineModified",           { fg = c.silver,   bg = c.surface1 })
hl("BufferLineModifiedSelected",   { fg = c.silver,   bg = c.bg })
hl("BufferLineSeparator",          { fg = c.bg_dark,  bg = c.surface1 })

-- which-key
hl("WhichKey",                     { fg = c.platinum })
hl("WhichKeyDesc",                 { fg = c.subtext1 })
hl("WhichKeyGroup",                { fg = c.ice,      bold = true })
hl("WhichKeySeparator",            { fg = c.overlay0 })
hl("WhichKeyBorder",               { fg = c.surface2 })
hl("WhichKeyNormal",               { bg = c.surface0 })

-- indent-blankline / mini.indentscope
hl("IblIndent",                    { fg = c.surface1 })
hl("IblScope",                     { fg = c.dk_ice })
hl("MiniIndentscopeSymbol",        { fg = c.dk_ice })

-- Snacks (dashboard)
hl("SnacksDashboardHeader",        { fg = c.bone,     bold = true })
hl("SnacksDashboardKey",           { fg = c.ice })
hl("SnacksDashboardDesc",          { fg = c.subtext0 })
hl("SnacksDashboardIcon",          { fg = c.silver })
hl("SnacksDashboardTitle",         { fg = c.bone,     bold = true })
hl("SnacksDashboardFooter",        { fg = c.overlay0, italic = true })

-- toggleterm
hl("ToggleTerm1FloatBorder",       { fg = c.dk_ice,   bg = c.surface0 })
hl("ToggleTermNormal",             { fg = c.text,     bg = c.surface0 })

-- coc.nvim
hl("CocFloating",                  { link = "NormalFloat" })
hl("CocMenuSel",                   { fg = c.bg,       bg = c.ice,      bold = true })
hl("CocSearch",                    { fg = c.bone,     bold = true })
hl("CocErrorSign",                 { fg = c.br_ice })
hl("CocWarningSign",               { fg = c.silver })
hl("CocInfoSign",                  { fg = c.ice })
hl("CocHintSign",                  { fg = c.overlay2 })
hl("CocErrorHighlight",            { sp = c.br_ice,   undercurl = true })
hl("CocWarningHighlight",          { sp = c.silver,   undercurl = true })
hl("CocHighlightText",             { bg = c.surface1 })
hl("CocCodeLens",                  { fg = c.overlay0, italic = true })
