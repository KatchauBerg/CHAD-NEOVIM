vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "matugen-universal"

package.loaded['matugen_colors'] = nil
local ok, c = pcall(require, 'matugen_colors')

if not ok then
    print("Matugen: Cores não encontradas.")
    return
end

local hl = vim.api.nvim_set_hl
local function set(name, opts)
    opts.force = true
    hl(0, name, opts)
end

-- ============================================================
--  UI BASE (TRANSPARENTE E LIMPA)
-- ============================================================
set("Normal",       { fg = c.foreground, bg = "NONE" })
set("NormalNC",     { fg = c.foreground, bg = "NONE" })
set("SignColumn",   { bg = "NONE" })
set("LineNr",       { fg = c.comment, bg = "NONE" })
set("CursorLineNr", { fg = c.primary, bold = true, bg = "NONE" })
set("VertSplit",    { fg = c.border, bg = "NONE" })
set("WinSeparator", { fg = c.border, bg = "NONE" })
set("CursorLine",   { bg = c.cursorline })
set("Visual",       { bg = c.selection, bold = true })
set("Directory",    { fg = c.primary, bold = true }) 

-- ============================================================
--  A SOLUÇÃO DO PROBLEMA: SINTAXE UNIVERSAL (VIM STANDARD)
-- ============================================================
set("Error",          { fg = c.error, bold = true })
set("ErrorMsg",       { fg = c.error, bold = true })
set("Exception",      { fg = c.error, bold = true })
set("WarningMsg",     { fg = c.warn, bold = true })
set("MoreMsg",        { fg = c.secondary })
set("ModeMsg",        { fg = c.tertiary, bold = true })

set("Comment",        { fg = c.comment, italic = true })
set("Constant",       { fg = c.tertiary, bold = true })
set("String",         { fg = c.tertiary })
set("Character",      { fg = c.tertiary })
set("Number",         { fg = c.secondary })
set("Boolean",        { fg = c.secondary, bold = true })
set("Float",          { fg = c.secondary })

set("Identifier",     { fg = c.foreground })
set("Function",       { fg = c.primary, bold = true })

set("Statement",      { fg = c.secondary, bold = true })
set("Conditional",    { fg = c.secondary, bold = true })
set("Repeat",         { fg = c.secondary, bold = true })
set("Label",          { fg = c.secondary, bold = true })
set("Operator",       { fg = c.primary, bold = true })
set("Keyword",        { fg = c.secondary, italic = true })
set("Exception",      { fg = c.error, bold = true })

set("PreProc",        { fg = c.tertiary })
set("Include",        { fg = c.tertiary })
set("Define",         { fg = c.tertiary })
set("Macro",          { fg = c.tertiary })
set("PreCondit",      { fg = c.tertiary })

set("Type",           { fg = c.primary, bold = true })
set("StorageClass",   { fg = c.secondary })
set("Structure",      { fg = c.primary })
set("Typedef",        { fg = c.primary })

set("Special",        { fg = c.secondary })
set("SpecialChar",    { fg = c.secondary })
set("Tag",            { fg = c.primary })
set("Delimiter",      { fg = c.foreground })
set("SpecialComment", { fg = c.comment, bold = true })
set("Debug",          { fg = c.error })

set("Underlined",     { fg = c.tertiary, underline = true })
set("Ignore",         { fg = c.comment })
set("Todo",           { fg = c.background, bg = c.primary, bold = true })

-- ============================================================
-- TREESITTER (REFINAMENTO MODERNO)
-- ============================================================
set("@variable",           { fg = c.foreground }) 
set("@variable.builtin",   { fg = c.secondary, italic = true }) 
set("@variable.parameter", { fg = c.tertiary, italic = true })  
set("@variable.member",    { fg = c.tertiary }) 
set("@property",           { fg = c.tertiary })

set("@function",           { fg = c.primary, bold = true }) 
set("@function.call",      { fg = c.primary, bold = true }) 
set("@function.builtin",   { fg = c.secondary, italic = true }) 
set("@function.macro",     { fg = c.secondary }) 
set("@constructor",        { fg = c.primary, bold = true }) 

set("@keyword",            { fg = c.secondary, italic = true }) 
set("@keyword.function",   { fg = c.secondary, italic = true }) 
set("@keyword.return",     { fg = c.secondary, italic = true })
set("@keyword.operator",   { fg = c.secondary }) 

set("@constant",           { fg = c.tertiary, bold = true }) 
set("@constant.builtin",   { fg = c.tertiary, bold = true }) 
set("@type",               { fg = c.primary, bold = true }) 
set("@type.builtin",       { fg = c.primary, bold = true })

set("@operator",              { fg = c.primary }) 
set("@punctuation.delimiter", { fg = c.primary }) 
set("@punctuation.bracket",   { fg = c.foreground }) 

set("@tag",                   { fg = c.primary, bold = true })
set("@tag.attribute",         { fg = c.secondary, italic = true })
set("@tag.delimiter",         { fg = c.foreground })

-- ============================================================
-- O "CATCH-ALL" PARA LSP (TOKEN SEMÂNTICO)
-- ============================================================
local lsp_kinds = {
    "type", "class", "enum", "interface", "struct", "typeParameter",
    "parameter", "variable", "property", "enumMember", "event", "function",
    "method", "macro", "keyword", "modifier", "comment", "string", "number",
    "regexp", "operator", "decorator"
}

for _, kind in ipairs(lsp_kinds) do
    set("@lsp.type." .. kind, { link = "@" .. kind })
end

set("@lsp.type.namespace", { fg = c.tertiary }) 
set("@lsp.type.parameter", { fg = c.tertiary, italic = true })
set("@lsp.mod.readonly",   { italic = true }) -- Constantes ficam itálico

-- ============================================================
-- PLUGINS E INTERFACE
-- ============================================================
set("NormalFloat",      { fg = c.foreground, bg = c.cursorline })
set("FloatBorder",      { fg = c.primary, bg = c.cursorline })
set("Pmenu",            { fg = c.foreground, bg = c.cursorline })
set("PmenuSel",         { fg = c.background, bg = c.primary, bold = true })
set("TelescopeNormal",  { link = "NormalFloat" })
set("TelescopeBorder",  { link = "FloatBorder" })

set("SnacksIndent",       { fg = c.comment }) 
set("SnacksIndentScope",  { fg = c.primary }) 
set("IblIndent",          { fg = c.comment })
set("IblScope",           { fg = c.primary })

set("SnacksDashboardHeader",  { fg = c.primary, bold = true })
set("SnacksDashboardIcon",    { fg = c.secondary, bold = true })
set("SnacksDashboardKey",     { fg = c.tertiary, bold = true })
set("SnacksDashboardDesc",    { fg = c.foreground })
set("SnacksDashboardFooter",  { fg = c.tertiary, italic = true }) 
set("SnacksDashboardSpecial", { fg = c.secondary }) 
set("SnacksPickerInputTitle", { fg = c.background, bg = c.primary, bold = true })
set("SnacksPickerBorder",     { fg = c.primary, bg = c.cursorline })
set("SnacksPickerMatch",      { fg = c.primary, bold = true, reverse = true })

set("SnacksExplorerDir",      { fg = c.primary, bold = true })
set("SnacksExplorerFolder",   { fg = c.secondary })
set("NvimTreeFolderIcon",     { fg = c.secondary })

set("GitSignsAdd",            { fg = c.primary, bg = "NONE", bold = true }) 
set("GitSignsChange",         { fg = c.secondary, bg = "NONE", bold = true }) 
set("GitSignsDelete",         { fg = c.error, bg = "NONE", bold = true })

set("Search",                 { fg = c.background, bg = c.primary, bold = true })
set("IncSearch",              { fg = c.background, bg = c.secondary, bold = true })

set("WhichKey",          { fg = c.primary, bold = true }) 
set("WhichKeyGroup",     { fg = c.secondary }) 
set("WhichKeyDesc",      { fg = c.foreground }) 
set("WhichKeyFloat",     { bg = c.cursorline }) 
set("WhichKeyBorder",    { fg = c.primary, bg = c.cursorline }) 

set("MiniIconsAzure",  { fg = c.secondary })
set("MiniIconsBlue",   { fg = c.secondary })
set("MiniIconsCyan",   { fg = c.secondary })
set("MiniIconsGreen",  { fg = c.secondary })
set("MiniIconsGrey",   { fg = c.secondary })
set("MiniIconsOrange", { fg = c.secondary })
set("MiniIconsPurple", { fg = c.secondary })
set("MiniIconsRed",    { fg = c.secondary })
set("MiniIconsYellow", { fg = c.secondary })

local icon_color = c.secondary 
local function paint_icons()
    local loaded, devicons = pcall(require, "nvim-web-devicons")
    if not loaded then return end
    for _, icon in pairs(devicons.get_icons()) do
        set("DevIcon" .. icon.name, { fg = icon_color })
    end
    pcall(function()
        local icons_by_filename = require("nvim-web-devicons.icons-by-filename").icons_by_filename
        for _, icon in pairs(icons_by_filename) do
            set("DevIcon" .. icon.name, { fg = icon_color })
        end
    end)
    set("DevIconDefault", { fg = icon_color })
end

paint_icons()
vim.api.nvim_create_autocmd("User", { pattern = "WebDevIconsLoaded", callback = paint_icons })
vim.api.nvim_create_autocmd("VimEnter", { callback = function() vim.schedule(paint_icons) end })
