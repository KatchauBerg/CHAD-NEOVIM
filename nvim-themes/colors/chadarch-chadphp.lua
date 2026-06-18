-- chadarch-chadphp: built for PHP — the elePHPant theme
-- Palette: official PHP indigo (#777bb3) family on a deep indigo-black bg,
-- periwinkle types, sage strings, one gold accent for money ($vars get paid).
-- Standalone theme — not tied to any dotfiles system theme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chadarch-chadphp"
vim.o.termguicolors = true

-- ─── Palette ──────────────────────────────────────────────────────────────────
-- Background: deep indigo-black, like the elePHPant at night
-- Text: cool porcelain white
-- Indigo: the PHP brand color — keywords, focus, flow
-- Sage: strings (calm against all that purple)
-- Gold: numbers, constants — the freelance invoice accent

local c = {
  bg       = "#0e0f17",   -- deep indigo-black
  bg_dark  = "#0a0b11",   -- darker void
  bg_0     = "#000000",   -- pure black
  surface0 = "#161827",   -- indigo charcoal
  surface1 = "#1e2133",   -- dusk
  surface2 = "#2b2f49",   -- midnight slate

  overlay0 = "#50547a",   -- dim indigo-steel (comments)
  overlay1 = "#6d72a0",   -- mid steel (line numbers)
  overlay2 = "#8f94bd",   -- light steel

  text     = "#d8daee",   -- porcelain
  subtext0 = "#aeb2d2",   -- dim porcelain
  subtext1 = "#c8cbe4",   -- light porcelain
  bright   = "#eef0fc",   -- brightest white (functions — glory)

  -- Accents
  indigo   = "#777bb3",   -- official PHP indigo (keywords)
  peri     = "#8892bf",   -- old-school PHP periwinkle (types, constants)
  lavender = "#a8aee0",   -- bright lavender ($this, builtins, return)
  dk_indigo= "#4f5b93",   -- PHP dark indigo (borders, subtle)
  sage     = "#a9c9a4",   -- sage green (strings)
  gold     = "#d9bb7f",   -- gold (numbers, the invoice accent)
  rose     = "#d99098",   -- soft rose (errors, exceptions)
  slate    = "#7a7f9e",   -- slate (operators, punctuation)
  shadow   = "#1d2038",   -- indigo shadow (selection bg)

  none     = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor chrome ────────────────────────────────────────────────────────────
hl("Normal",          { fg = c.text,     bg = c.bg })
hl("NormalNC",        { fg = c.text,     bg = c.bg_dark })
hl("NormalFloat",     { fg = c.text,     bg = c.surface0 })
hl("FloatBorder",     { fg = c.dk_indigo, bg = c.surface0 })
hl("FloatTitle",      { fg = c.bright,   bg = c.surface0, bold = true })
hl("SignColumn",      { fg = c.overlay0, bg = c.bg })
hl("LineNr",          { fg = c.overlay1 })
hl("CursorLineNr",    { fg = c.lavender, bold = true })
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
hl("PmenuSel",        { fg = c.bg,       bg = c.indigo,   bold = true })
hl("PmenuSbar",       { bg = c.surface1 })
hl("PmenuThumb",      { bg = c.overlay1 })
hl("PmenuBorder",     { fg = c.surface2, bg = c.surface0 })

-- ─── Search & selection ───────────────────────────────────────────────────────
hl("Search",          { fg = c.bg,       bg = c.peri })
hl("CurSearch",       { fg = c.bg,       bg = c.gold,     bold = true })
hl("IncSearch",       { fg = c.bg,       bg = c.gold })
hl("Visual",          { bg = c.shadow })
hl("VisualNOS",       { bg = c.surface1 })
hl("Substitute",      { fg = c.bg,       bg = c.indigo })

-- ─── Messages ─────────────────────────────────────────────────────────────────
hl("ModeMsg",         { fg = c.lavender, bold = true })
hl("MsgArea",         { fg = c.subtext0 })
hl("MoreMsg",         { fg = c.indigo })
hl("WarningMsg",      { fg = c.gold })
hl("ErrorMsg",        { fg = c.rose,     bold = true })
hl("Question",        { fg = c.indigo })

-- ─── Diff ─────────────────────────────────────────────────────────────────────
hl("DiffAdd",         { fg = c.sage,     bg = "#14201a" })
hl("DiffChange",      { fg = c.peri,     bg = "#161a2b" })
hl("DiffDelete",      { fg = c.rose,     bg = "#201418" })
hl("DiffText",        { fg = c.lavender, bg = "#1c2040", bold = true })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
hl("NonText",         { fg = c.overlay2 })
hl("SpecialKey",      { fg = c.overlay0 })
hl("Whitespace",      { fg = c.surface2 })
hl("Directory",       { fg = c.lavender, bold = true })
hl("Title",           { fg = c.bright,   bold = true })
hl("MatchParen",      { fg = c.gold,     bg = c.surface1, bold = true })
hl("SpellBad",        { sp = c.rose,     undercurl = true })
hl("SpellCap",        { sp = c.gold,     undercurl = true })
hl("SpellLocal",      { sp = c.slate,    undercurl = true })
hl("SpellRare",       { sp = c.dk_indigo, undercurl = true })
hl("EndOfBuffer",     { fg = c.bg })
hl("Conceal",         { fg = c.overlay0 })

-- ─── Syntax (legacy) ──────────────────────────────────────────────────────────
hl("Comment",         { fg = c.overlay0, italic = true })
hl("Constant",        { fg = c.gold })
hl("String",          { fg = c.sage })
hl("Character",       { fg = c.sage })
hl("Number",          { fg = c.gold })
hl("Boolean",         { fg = c.lavender, bold = true })
hl("Float",           { fg = c.gold })
hl("Identifier",      { fg = c.text })
hl("Function",        { fg = c.bright,   bold = true })
hl("Statement",       { fg = c.indigo })
hl("Conditional",     { fg = c.indigo })
hl("Repeat",          { fg = c.indigo })
hl("Label",           { fg = c.lavender })
hl("Operator",        { fg = c.slate })
hl("Keyword",         { fg = c.indigo,   bold = true })
hl("Exception",       { fg = c.rose,     bold = true })
hl("PreProc",         { fg = c.lavender })
hl("Include",         { fg = c.lavender })
hl("Define",          { fg = c.lavender })
hl("Macro",           { fg = c.peri })
hl("PreCondit",       { fg = c.lavender })
hl("Type",            { fg = c.peri })
hl("StorageClass",    { fg = c.indigo })
hl("Structure",       { fg = c.peri })
hl("Typedef",         { fg = c.peri })
hl("Special",         { fg = c.lavender })
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
hl("@variable.builtin",      { fg = c.lavender, italic = true })  -- $this
hl("@variable.parameter",    { fg = c.subtext1 })
hl("@variable.member",       { fg = c.subtext0 })

hl("@constant",              { fg = c.gold })
hl("@constant.builtin",      { fg = c.gold,     bold = true })    -- PHP_EOL, true, null
hl("@constant.macro",        { fg = c.gold })

hl("@module",                { fg = c.peri,     bold = true })    -- namespaces
hl("@label",                 { fg = c.lavender })

hl("@string",                { fg = c.sage })
hl("@string.escape",         { fg = c.gold })
hl("@string.special",        { fg = c.lavender })
hl("@string.regex",          { fg = c.gold })

hl("@character",             { fg = c.sage })
hl("@number",                { fg = c.gold })
hl("@float",                 { fg = c.gold })
hl("@boolean",               { fg = c.lavender, bold = true })

hl("@function",              { fg = c.bright,   bold = true })
hl("@function.builtin",      { fg = c.bright,   italic = true })  -- array_map et al.
hl("@function.call",         { fg = c.subtext1 })
hl("@function.macro",        { fg = c.peri })
hl("@function.method",       { fg = c.bright,   bold = true })
hl("@function.method.call",  { fg = c.subtext1 })

hl("@constructor",           { fg = c.peri,     bold = true })    -- new Foo()
hl("@operator",              { fg = c.slate })

hl("@keyword",               { fg = c.indigo,   bold = true })
hl("@keyword.function",      { fg = c.indigo,   bold = true })    -- function, fn
hl("@keyword.operator",      { fg = c.indigo })                   -- instanceof, new
hl("@keyword.return",        { fg = c.lavender, bold = true })
hl("@keyword.import",        { fg = c.lavender })                 -- use, require
hl("@keyword.modifier",      { fg = c.indigo,   italic = true })  -- public, static, readonly
hl("@keyword.conditional",   { fg = c.indigo })
hl("@keyword.repeat",        { fg = c.indigo })
hl("@keyword.exception",     { fg = c.rose,     bold = true })    -- try, catch, throw

hl("@type",                  { fg = c.peri })
hl("@type.builtin",          { fg = c.peri,     italic = true })  -- int, string, array
hl("@type.definition",       { fg = c.peri })

hl("@attribute",             { fg = c.gold,     italic = true })  -- #[Attribute]
hl("@property",              { fg = c.subtext0 })

hl("@punctuation",           { fg = c.slate })
hl("@punctuation.bracket",   { fg = c.slate })
hl("@punctuation.delimiter", { fg = c.slate })
hl("@punctuation.special",   { fg = c.lavender })                 -- ${} interpolation

hl("@comment",               { fg = c.overlay0, italic = true })
hl("@comment.documentation", { fg = c.overlay1, italic = true })  -- phpdoc
hl("@comment.todo",          { fg = c.bg,       bg = c.gold,     bold = true })
hl("@comment.note",          { fg = c.bg,       bg = c.indigo,   bold = true })
hl("@comment.warning",       { fg = c.bg,       bg = c.peri,     bold = true })
hl("@comment.error",         { fg = c.bg,       bg = c.rose,     bold = true })

hl("@tag",                   { fg = c.indigo })                   -- <?php and HTML tags
hl("@tag.attribute",         { fg = c.peri })
hl("@tag.delimiter",         { fg = c.slate })

hl("@markup.heading",        { fg = c.bright,   bold = true })
hl("@markup.link",           { fg = c.indigo,   underline = true })
hl("@markup.link.url",       { fg = c.sage,     underline = true })
hl("@markup.raw",            { fg = c.peri })
hl("@markup.italic",         { fg = c.subtext1, italic = true })
hl("@markup.strong",         { fg = c.bright,   bold = true })
hl("@markup.list",           { fg = c.indigo })

-- ─── PHP specifics ────────────────────────────────────────────────────────────
-- Treesitter php captures
hl("@variable.php",            { fg = c.text })                   -- $vars
hl("@variable.builtin.php",    { fg = c.lavender, italic = true, bold = true })  -- $this
hl("@string.documentation.php",{ fg = c.overlay1, italic = true })

-- phpdoc parser
hl("@attribute.phpdoc",        { fg = c.indigo,   italic = true }) -- @param, @return
hl("@type.phpdoc",             { fg = c.peri,     italic = true })

-- Legacy vim php syntax (when treesitter off)
hl("phpVarSelector",           { fg = c.lavender })               -- the $ sigil
hl("phpIdentifier",            { fg = c.text })
hl("phpMethodsVar",            { fg = c.subtext0 })
hl("phpParent",                { fg = c.slate })
hl("phpKeyword",               { fg = c.indigo,   bold = true })
hl("phpStatement",             { fg = c.indigo })
hl("phpType",                  { fg = c.peri,     italic = true })
hl("phpRegion",                { fg = c.text })
hl("phpDocTags",               { fg = c.indigo,   italic = true })
hl("phpDocParam",              { fg = c.peri,     italic = true })

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
hl("@lsp.typemod.method.static",   { fg = c.bright, italic = true, bold = true })
hl("@lsp.typemod.property.static", { fg = c.subtext0, italic = true })

-- ─── Diagnostics ──────────────────────────────────────────────────────────────
hl("DiagnosticError",              { fg = c.rose })
hl("DiagnosticWarn",               { fg = c.gold })
hl("DiagnosticInfo",               { fg = c.indigo })
hl("DiagnosticHint",               { fg = c.overlay2 })
hl("DiagnosticOk",                 { fg = c.sage })
hl("DiagnosticUnderlineError",     { sp = c.rose,     undercurl = true })
hl("DiagnosticUnderlineWarn",      { sp = c.gold,     undercurl = true })
hl("DiagnosticUnderlineInfo",      { sp = c.indigo,   undercurl = true })
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
hl("GitSignsAdd",                  { fg = c.sage })
hl("GitSignsChange",               { fg = c.peri })
hl("GitSignsDelete",               { fg = c.rose })

-- nvim-tree
hl("NvimTreeNormal",               { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeNormalNC",             { fg = c.text,     bg = c.bg_dark })
hl("NvimTreeRootFolder",           { fg = c.lavender, bold = true })
hl("NvimTreeFolderName",           { fg = c.subtext1 })
hl("NvimTreeOpenedFolderName",     { fg = c.lavender, bold = true })
hl("NvimTreeFolderIcon",           { fg = c.indigo })
hl("NvimTreeFileIcon",             { fg = c.overlay1 })
hl("NvimTreeExecFile",             { fg = c.sage,     bold = true })
hl("NvimTreeGitNew",               { fg = c.sage })
hl("NvimTreeGitDirty",             { fg = c.gold })
hl("NvimTreeGitDeleted",           { fg = c.rose })
hl("NvimTreeSpecialFile",          { fg = c.indigo })
hl("NvimTreeIndentMarker",         { fg = c.surface2 })
hl("NvimTreeWinSeparator",         { fg = c.surface2, bg = c.bg_dark })
hl("NvimTreeCursorLine",           { bg = c.surface0 })
hl("NvimTreeSymlink",              { fg = c.indigo })
hl("NvimTreeImageFile",            { fg = c.peri })

-- Telescope
hl("TelescopeNormal",              { fg = c.text,     bg = c.surface0 })
hl("TelescopeBorder",              { fg = c.dk_indigo, bg = c.surface0 })
hl("TelescopePromptNormal",        { fg = c.text,     bg = c.surface1 })
hl("TelescopePromptBorder",        { fg = c.indigo,   bg = c.surface1 })
hl("TelescopePromptTitle",         { fg = c.bg,       bg = c.indigo,   bold = true })
hl("TelescopePreviewTitle",        { fg = c.bg,       bg = c.lavender, bold = true })
hl("TelescopeResultsTitle",        { fg = c.dk_indigo, bg = c.surface0 })
hl("TelescopeMatching",            { fg = c.gold,     bold = true })
hl("TelescopeSelection",           { fg = c.bright,   bg = c.shadow })
hl("TelescopePromptPrefix",        { fg = c.indigo })
hl("TelescopeMultiSelection",      { fg = c.peri })

-- bufferline
hl("BufferLineFill",               { bg = c.bg_dark })
hl("BufferLineBackground",         { fg = c.overlay1, bg = c.surface1 })
hl("BufferLineBufferSelected",     { fg = c.bright,   bg = c.bg,       bold = true })
hl("BufferLineIndicatorSelected",  { fg = c.indigo,   bg = c.bg })
hl("BufferLineModified",           { fg = c.gold,     bg = c.surface1 })
hl("BufferLineModifiedSelected",   { fg = c.gold,     bg = c.bg })
hl("BufferLineSeparator",          { fg = c.bg_dark,  bg = c.surface1 })

-- which-key
hl("WhichKey",                     { fg = c.bright })
hl("WhichKeyDesc",                 { fg = c.subtext1 })
hl("WhichKeyGroup",                { fg = c.indigo,   bold = true })
hl("WhichKeySeparator",            { fg = c.overlay0 })
hl("WhichKeyBorder",               { fg = c.surface2 })
hl("WhichKeyNormal",               { bg = c.surface0 })

-- indent-blankline / mini.indentscope
hl("IblIndent",                    { fg = c.surface1 })
hl("IblScope",                     { fg = c.dk_indigo })
hl("MiniIndentscopeSymbol",        { fg = c.dk_indigo })

-- Snacks (dashboard)
hl("SnacksDashboardHeader",        { fg = c.indigo,   bold = true })
hl("SnacksDashboardKey",           { fg = c.gold })
hl("SnacksDashboardDesc",          { fg = c.subtext0 })
hl("SnacksDashboardIcon",          { fg = c.peri })
hl("SnacksDashboardTitle",         { fg = c.bright,   bold = true })
hl("SnacksDashboardFooter",        { fg = c.overlay0, italic = true })

-- toggleterm
hl("ToggleTerm1FloatBorder",       { fg = c.dk_indigo, bg = c.surface0 })
hl("ToggleTermNormal",             { fg = c.text,     bg = c.surface0 })

-- coc.nvim
hl("CocFloating",                  { link = "NormalFloat" })
hl("CocMenuSel",                   { fg = c.bg,       bg = c.indigo,   bold = true })
hl("CocSearch",                    { fg = c.gold,     bold = true })
hl("CocErrorSign",                 { fg = c.rose })
hl("CocWarningSign",               { fg = c.gold })
hl("CocInfoSign",                  { fg = c.indigo })
hl("CocHintSign",                  { fg = c.overlay2 })
hl("CocErrorHighlight",            { sp = c.rose,     undercurl = true })
hl("CocWarningHighlight",          { sp = c.gold,     undercurl = true })
hl("CocHighlightText",             { bg = c.surface1 })
hl("CocCodeLens",                  { fg = c.overlay0, italic = true })
