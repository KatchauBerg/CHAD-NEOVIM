-- chadarch-china: the Middle Kingdom theme
-- Palette: China-flag scarlet (#de2910) + imperial gold (#ffde00) on a deep
-- lacquer-black bg, with jade green for strings and ink-wash neutrals.
-- Standalone theme — not tied to any dotfiles system theme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chadarch-china"
vim.o.termguicolors = true

-- ─── Palette ──────────────────────────────────────────────────────────────────
-- Background: deep lacquer-black with a warm red undertone
-- Text: rice-paper white
-- Scarlet: the flag red — keywords, focus, flow
-- Gold: the five stars — functions, numbers, constants
-- Jade: strings (calm green against all that red)

local c = {
  bg       = "#170a0a",   -- deep lacquer-black, warm red undertone
  bg_dark  = "#100707",   -- darker lacquer
  bg_0     = "#000000",   -- pure black
  surface0 = "#241010",   -- oxblood charcoal
  surface1 = "#321616",   -- dark cinnabar
  surface2 = "#451d1d",   -- dried-blood slate

  overlay0 = "#7a4a45",   -- dim clay (comments)
  overlay1 = "#9a635c",   -- mid clay (line numbers)
  overlay2 = "#c08a82",   -- light clay

  text     = "#f3e6df",   -- rice-paper
  subtext0 = "#d8c2b8",   -- dim rice-paper
  subtext1 = "#e9d6cd",   -- light rice-paper
  bright   = "#fff6ee",   -- brightest white (functions — glory)

  -- Accents
  scarlet  = "#de2910",   -- China-flag red (keywords)
  red_lt   = "#f24c34",   -- bright scarlet (conditionals, emphasis)
  gold     = "#ffde00",   -- imperial gold (functions, numbers, stars)
  gold_dk  = "#d4af37",   -- antique gold (borders, subtle accent)
  jade     = "#3fa66a",   -- jade green (strings)
  jade_lt  = "#6fcf97",   -- bright jade ($this, builtins, return)
  porcelain= "#8fb6c9",   -- porcelain blue (types, constants)
  slate    = "#a8857e",   -- warm slate (operators, punctuation)
  rose     = "#ff6b5e",   -- soft coral (errors, exceptions)
  shadow   = "#3a1414",   -- cinnabar shadow (selection bg)

  none     = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor chrome ────────────────────────────────────────────────────────────
hl("Normal",          { fg = c.text,     bg = c.bg })
hl("NormalNC",        { fg = c.text,     bg = c.bg_dark })
hl("NormalFloat",     { fg = c.text,     bg = c.surface0 })
hl("FloatBorder",     { fg = c.gold_dk,  bg = c.surface0 })
hl("FloatTitle",      { fg = c.bright,   bg = c.surface0, bold = true })
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
hl("TabLineSel",      { fg = c.bright,   bg = c.surface0, bold = true })

-- ─── Popup menu ───────────────────────────────────────────────────────────────
hl("Pmenu",           { fg = c.text,     bg = c.surface0 })
hl("PmenuSel",        { fg = c.bg,       bg = c.scarlet,  bold = true })
hl("PmenuSbar",       { bg = c.surface1 })
hl("PmenuThumb",      { bg = c.overlay1 })
hl("PmenuBorder",     { fg = c.surface2, bg = c.surface0 })

-- ─── Search & selection ───────────────────────────────────────────────────────
hl("Search",          { fg = c.bg,       bg = c.gold_dk })
hl("CurSearch",       { fg = c.bg,       bg = c.gold,     bold = true })
hl("IncSearch",       { fg = c.bg,       bg = c.gold })
hl("Visual",          { bg = c.shadow })
hl("VisualNOS",       { bg = c.surface1 })
hl("Substitute",      { fg = c.bg,       bg = c.scarlet })

-- ─── Messages ─────────────────────────────────────────────────────────────────
hl("ModeMsg",         { fg = c.gold,     bold = true })
hl("MsgArea",         { fg = c.subtext0 })
hl("MoreMsg",         { fg = c.scarlet })
hl("WarningMsg",      { fg = c.gold })
hl("ErrorMsg",        { fg = c.rose,     bold = true })
hl("Question",        { fg = c.scarlet })

-- ─── Diff ─────────────────────────────────────────────────────────────────────
hl("DiffAdd",         { fg = c.jade,     bg = "#10200f" })
hl("DiffChange",      { fg = c.gold,     bg = "#221a08" })
hl("DiffDelete",      { fg = c.rose,     bg = "#2a1010" })
hl("DiffText",        { fg = c.gold,     bg = "#332608", bold = true })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
hl("NonText",         { fg = c.overlay2 })
hl("SpecialKey",      { fg = c.overlay0 })
hl("Whitespace",      { fg = c.surface2 })
hl("Directory",       { fg = c.gold,     bold = true })
hl("Title",           { fg = c.bright,   bold = true })
hl("MatchParen",      { fg = c.gold,     bg = c.surface1, bold = true })
hl("SpellBad",        { sp = c.rose,     undercurl = true })
hl("SpellCap",        { sp = c.gold,     undercurl = true })
hl("SpellLocal",      { sp = c.slate,    undercurl = true })
hl("SpellRare",       { sp = c.gold_dk,  undercurl = true })
hl("EndOfBuffer",     { fg = c.bg })
hl("Conceal",         { fg = c.overlay0 })

-- ─── Syntax (legacy) ──────────────────────────────────────────────────────────
hl("Comment",         { fg = c.overlay0, italic = true })
hl("Constant",        { fg = c.gold })
hl("String",          { fg = c.jade })
hl("Character",       { fg = c.jade })
hl("Number",          { fg = c.gold })
hl("Boolean",         { fg = c.red_lt,   bold = true })
hl("Float",           { fg = c.gold })
hl("Identifier",      { fg = c.text })
hl("Function",        { fg = c.gold,     bold = true })
hl("Statement",       { fg = c.scarlet })
hl("Conditional",     { fg = c.scarlet })
hl("Repeat",          { fg = c.scarlet })
hl("Label",           { fg = c.red_lt })
hl("Operator",        { fg = c.slate })
hl("Keyword",         { fg = c.scarlet,  bold = true })
hl("Exception",       { fg = c.rose,     bold = true })
hl("PreProc",         { fg = c.red_lt })
hl("Include",         { fg = c.red_lt })
hl("Define",          { fg = c.red_lt })
hl("Macro",           { fg = c.porcelain })
hl("PreCondit",       { fg = c.red_lt })
hl("Type",            { fg = c.porcelain })
hl("StorageClass",    { fg = c.scarlet })
hl("Structure",       { fg = c.porcelain })
hl("Typedef",         { fg = c.porcelain })
hl("Special",         { fg = c.gold })
hl("SpecialChar",     { fg = c.gold })
hl("Tag",             { fg = c.bright })
hl("Delimiter",       { fg = c.slate })
hl("SpecialComment",  { fg = c.overlay2, italic = true })
hl("Debug",           { fg = c.rose })
hl("Underlined",      { underline = true })
hl("Ignore",          { fg = c.overlay0 })
hl("Error",           { fg = c.rose,     bold = true, underline = true })
hl("Todo",            { fg = c.bg,       bg = c.gold,  bold = true })

-- ─── Treesitter ───────────────────────────────────────────────────────────────
hl("@variable",              { fg = c.text })
hl("@variable.builtin",      { fg = c.jade_lt,  italic = true })
hl("@variable.parameter",    { fg = c.subtext1 })
hl("@variable.member",       { fg = c.subtext0 })

hl("@constant",              { fg = c.gold })
hl("@constant.builtin",      { fg = c.gold,     bold = true })
hl("@constant.macro",        { fg = c.gold })

hl("@module",                { fg = c.porcelain, bold = true })
hl("@label",                 { fg = c.red_lt })

hl("@string",                { fg = c.jade })
hl("@string.escape",         { fg = c.gold })
hl("@string.special",        { fg = c.gold })
hl("@string.regex",          { fg = c.gold })

hl("@character",             { fg = c.jade })
hl("@number",                { fg = c.gold })
hl("@float",                 { fg = c.gold })
hl("@boolean",               { fg = c.red_lt,   bold = true })

hl("@function",              { fg = c.gold,     bold = true })
hl("@function.builtin",      { fg = c.gold,     italic = true })
hl("@function.call",         { fg = c.subtext1 })
hl("@function.macro",        { fg = c.porcelain })
hl("@function.method",       { fg = c.gold,     bold = true })
hl("@function.method.call",  { fg = c.subtext1 })

hl("@constructor",           { fg = c.porcelain, bold = true })
hl("@operator",              { fg = c.slate })

hl("@keyword",               { fg = c.scarlet,  bold = true })
hl("@keyword.function",      { fg = c.scarlet,  bold = true })
hl("@keyword.operator",      { fg = c.scarlet })
hl("@keyword.return",        { fg = c.jade_lt,  bold = true })
hl("@keyword.import",        { fg = c.red_lt })
hl("@keyword.modifier",      { fg = c.scarlet,  italic = true })
hl("@keyword.conditional",   { fg = c.scarlet })
hl("@keyword.repeat",        { fg = c.scarlet })
hl("@keyword.exception",     { fg = c.rose,     bold = true })

hl("@type",                  { fg = c.porcelain })
hl("@type.builtin",          { fg = c.porcelain, italic = true })
hl("@type.definition",       { fg = c.porcelain })

hl("@attribute",             { fg = c.gold,     italic = true })
hl("@property",              { fg = c.subtext0 })

hl("@punctuation",           { fg = c.slate })
hl("@punctuation.bracket",   { fg = c.slate })
hl("@punctuation.delimiter", { fg = c.slate })
hl("@punctuation.special",   { fg = c.gold })

hl("@comment",               { fg = c.overlay0, italic = true })
hl("@comment.documentation", { fg = c.overlay1, italic = true })
hl("@comment.todo",          { fg = c.bg,       bg = c.gold,     bold = true })
hl("@comment.note",          { fg = c.bg,       bg = c.scarlet,  bold = true })
hl("@comment.warning",       { fg = c.bg,       bg = c.gold,     bold = true })
hl("@comment.error",         { fg = c.bg,       bg = c.rose,     bold = true })

hl("@tag",                   { fg = c.scarlet })
hl("@tag.attribute",         { fg = c.porcelain })
hl("@tag.delimiter",         { fg = c.slate })

hl("@markup.heading",        { fg = c.bright,   bold = true })
hl("@markup.link",           { fg = c.scarlet,  underline = true })
hl("@markup.link.url",       { fg = c.jade,     underline = true })
hl("@markup.raw",            { fg = c.porcelain })
hl("@markup.italic",         { fg = c.subtext1, italic = true })
hl("@markup.strong",         { fg = c.bright,   bold = true })
hl("@markup.list",           { fg = c.scarlet })

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
hl("@lsp.mod.static",        { italic = true })
hl("@lsp.typemod.method.static",   { fg = c.gold,    italic = true, bold = true })
hl("@lsp.typemod.property.static", { fg = c.subtext0, italic = true })

-- ─── Diagnostics ──────────────────────────────────────────────────────────────
hl("DiagnosticError",              { fg = c.rose })
hl("DiagnosticWarn",               { fg = c.gold })
hl("DiagnosticInfo",               { fg = c.porcelain })
hl("DiagnosticHint",               { fg = c.overlay2 })
hl("DiagnosticOk",                 { fg = c.jade })
hl("DiagnosticUnderlineError",     { sp = c.rose,     undercurl = true })
hl("DiagnosticUnderlineWarn",      { sp = c.gold,     undercurl = true })
hl("DiagnosticUnderlineInfo",      { sp = c.porcelain, undercurl = true })
hl("DiagnosticUnderlineHint",      { sp = c.overlay2, undercurl = true })
hl("DiagnosticVirtualTextError",   { fg = c.rose,     italic = true })
hl("DiagnosticVirtualTextWarn",    { fg = c.gold,     italic = true })
hl("DiagnosticVirtualTextInfo",    { fg = c.overlay1, italic = true })
hl("DiagnosticVirtualTextHint",    { fg = c.overlay0, italic = true })
hl("LspReferenceText",             { bg = c.surface1 })
hl("LspReferenceRead",             { bg = c.surface1 })
hl("LspReferenceWrite",            { bg = c.surface2 })
hl("LspSignatureActiveParameter",  { fg = c.gold,     bold = true })
hl("LspInfoBorder",                { fg = c.surface2 })

-- ─── Plugins ──────────────────────────────────────────────────────────────────

-- gitsigns
hl("GitSignsAdd",                  { fg = c.jade })
hl("GitSignsChange",               { fg = c.gold })
hl("GitSignsDelete",               { fg = c.rose })

-- nvim-tree
hl("NvimTreeNormal",               { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeNormalNC",             { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeRootFolder",           { fg = c.gold,     bold = true })
hl("NvimTreeFolderName",           { fg = c.subtext1 })
hl("NvimTreeOpenedFolderName",     { fg = c.gold,     bold = true })
hl("NvimTreeFolderIcon",           { fg = c.scarlet })
hl("NvimTreeFileIcon",             { fg = c.overlay1 })
hl("NvimTreeExecFile",             { fg = c.jade,     bold = true })
hl("NvimTreeGitNew",               { fg = c.jade })
hl("NvimTreeGitDirty",             { fg = c.gold })
hl("NvimTreeGitDeleted",           { fg = c.rose })
hl("NvimTreeSpecialFile",          { fg = c.scarlet })
hl("NvimTreeIndentMarker",         { fg = c.surface2 })
hl("NvimTreeWinSeparator",         { fg = c.surface2, bg = c.bg_dark })
hl("NvimTreeCursorLine",           { bg = c.surface0 })
hl("NvimTreeSymlink",              { fg = c.scarlet })
hl("NvimTreeImageFile",            { fg = c.porcelain })

-- Telescope
hl("TelescopeNormal",              { fg = c.text,     bg = c.surface0 })
hl("TelescopeBorder",              { fg = c.gold_dk,  bg = c.surface0 })
hl("TelescopePromptNormal",        { fg = c.text,     bg = c.surface1 })
hl("TelescopePromptBorder",        { fg = c.scarlet,  bg = c.surface1 })
hl("TelescopePromptTitle",         { fg = c.bg,       bg = c.scarlet,  bold = true })
hl("TelescopePreviewTitle",        { fg = c.bg,       bg = c.gold,     bold = true })
hl("TelescopeResultsTitle",        { fg = c.gold_dk,  bg = c.surface0 })
hl("TelescopeMatching",            { fg = c.gold,     bold = true })
hl("TelescopeSelection",           { fg = c.bright,   bg = c.shadow })
hl("TelescopePromptPrefix",        { fg = c.scarlet })
hl("TelescopeMultiSelection",      { fg = c.gold })

-- bufferline
hl("BufferLineFill",               { bg = c.bg_dark })
hl("BufferLineBackground",         { fg = c.overlay1, bg = c.surface1 })
hl("BufferLineBufferSelected",     { fg = c.bright,   bg = c.bg,       bold = true })
hl("BufferLineIndicatorSelected",  { fg = c.scarlet,  bg = c.bg })
hl("BufferLineModified",           { fg = c.gold,     bg = c.surface1 })
hl("BufferLineModifiedSelected",   { fg = c.gold,     bg = c.bg })
hl("BufferLineSeparator",          { fg = c.bg_dark,  bg = c.surface1 })

-- which-key
hl("WhichKey",                     { fg = c.bright })
hl("WhichKeyDesc",                 { fg = c.subtext1 })
hl("WhichKeyGroup",                { fg = c.scarlet,  bold = true })
hl("WhichKeySeparator",            { fg = c.overlay0 })
hl("WhichKeyBorder",               { fg = c.surface2 })
hl("WhichKeyNormal",               { bg = c.surface0 })

-- indent-blankline / mini.indentscope
hl("IblIndent",                    { fg = c.surface1 })
hl("IblScope",                     { fg = c.gold_dk })
hl("MiniIndentscopeSymbol",        { fg = c.gold_dk })

-- Snacks (dashboard)
hl("SnacksDashboardHeader",        { fg = c.scarlet,  bold = true })
hl("SnacksDashboardKey",           { fg = c.gold })
hl("SnacksDashboardDesc",          { fg = c.subtext0 })
hl("SnacksDashboardIcon",          { fg = c.gold })
hl("SnacksDashboardTitle",         { fg = c.bright,   bold = true })
hl("SnacksDashboardFooter",        { fg = c.overlay0, italic = true })

-- toggleterm
hl("ToggleTerm1FloatBorder",       { fg = c.gold_dk,  bg = c.surface0 })
hl("ToggleTermNormal",             { fg = c.text,     bg = c.surface0 })

-- coc.nvim
hl("CocFloating",                  { link = "NormalFloat" })
hl("CocMenuSel",                   { fg = c.bg,       bg = c.scarlet,  bold = true })
hl("CocSearch",                    { fg = c.gold,     bold = true })
hl("CocErrorSign",                 { fg = c.rose })
hl("CocWarningSign",               { fg = c.gold })
hl("CocInfoSign",                  { fg = c.porcelain })
hl("CocHintSign",                  { fg = c.overlay2 })
hl("CocErrorHighlight",            { sp = c.rose,     undercurl = true })
hl("CocWarningHighlight",          { sp = c.gold,     undercurl = true })
hl("CocHighlightText",             { bg = c.surface1 })
hl("CocCodeLens",                  { fg = c.overlay0, italic = true })
