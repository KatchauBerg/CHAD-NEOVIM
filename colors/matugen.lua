-- 1. PREPARAÇÃO
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "matugen"

-- 2. CARREGAMENTO DE DADOS
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
-- 3. INTERFACE BASE
-- ============================================================
set("Normal",       { fg = c.foreground, bg = "NONE" })
set("NormalNC",     { fg = c.foreground, bg = "NONE" })
set("SignColumn",   { bg = "NONE" })
set("LineNr",       { fg = c.comment, bg = "NONE" })
set("CursorLineNr", { fg = c.primary, bold = true, bg = "NONE" })
set("VertSplit",    { fg = c.border, bg = "NONE" })
set("WinSeparator", { fg = c.border, bg = "NONE" })
set("CursorLine",   { bg = c.cursorline })
set("Visual",       { bg = c.selection })
set("Directory",    { fg = c.primary, bold = true }) 

-- >>> VARIÁVEIS <<<
set("@variable",           { fg = c.foreground }) 
set("@variable.builtin",   { fg = c.secondary, italic = true }) 
set("@variable.parameter", { fg = c.tertiary, italic = true })  
set("@variable.member",    { fg = c.tertiary }) 
set("@property",           { fg = c.tertiary })
set("@field",              { fg = c.tertiary })

-- >>> FUNÇÕES E COMANDOS <<<
set("@function",           { fg = c.primary, bold = true }) 
set("@function.call",      { fg = c.primary, bold = true }) 
set("@function.builtin",   { fg = c.secondary, italic = true }) 
set("@function.macro",     { fg = c.secondary }) 
set("@constructor",        { fg = c.primary, bold = true }) 

-- >>> PALAVRAS-CHAVE <<<
set("@keyword",            { fg = c.secondary, italic = true }) 
set("@keyword.function",   { fg = c.secondary, italic = true }) 
set("@keyword.return",     { fg = c.secondary, italic = true })
set("@keyword.operator",   { fg = c.secondary }) 
set("@conditional",        { link = "@keyword" })
set("@repeat",             { link = "@keyword" })

-- >>> CONSTANTES E TIPOS <<<
set("@constant",           { fg = c.tertiary, bold = true }) 
set("@constant.builtin",   { fg = c.tertiary, bold = true }) 
set("@string",             { fg = c.tertiary }) 
set("@character",          { fg = c.tertiary })
set("@number",             { fg = c.secondary }) 
set("@boolean",            { fg = c.secondary, bold = true })
set("@float",              { fg = c.secondary })
set("@type",               { fg = c.primary }) 
set("@type.builtin",       { fg = c.primary })

-- >>> PONTUAÇÃO <<<
set("@operator",              { fg = c.secondary }) 
set("@punctuation.delimiter", { fg = c.secondary }) 
set("@punctuation.bracket",   { fg = c.foreground }) 

-- >>> TAGS <<<
set("@tag",                   { fg = c.primary })
set("@tag.attribute",         { fg = c.tertiary, italic = true })
set("@tag.delimiter",         { fg = c.secondary })

-- >>> INTERFACE FLUTUANTE <<<
set("NormalFloat",      { fg = c.foreground, bg = c.cursorline })
set("FloatBorder",      { fg = c.primary, bg = c.cursorline })
set("Pmenu",            { fg = c.foreground, bg = c.cursorline })
set("PmenuSel",         { fg = c.background, bg = c.primary, bold = true })
set("TelescopeNormal",  { link = "NormalFloat" })
set("TelescopeBorder",  { link = "FloatBorder" })

-- >> INDENTAÇÃO <<
set("SnacksIndent",       { fg = c.comment }) 
set("SnacksIndentScope",  { fg = c.primary }) 
set("IblIndent",          { fg = c.comment })
set("IblScope",           { fg = c.primary })

-- >> DASHBOARD <<
set("SnacksDashboardHeader",  { fg = c.primary, bold = true })
set("SnacksDashboardIcon",    { fg = c.secondary })
set("SnacksDashboardKey",     { fg = c.tertiary, bold = true })
set("SnacksDashboardDesc",    { fg = c.foreground })
set("SnacksDashboardFooter",  { fg = c.tertiary, italic = true }) 
set("SnacksDashboardSpecial", { fg = c.secondary }) 
set("SnacksPickerInputTitle", { fg = c.background, bg = c.primary, bold = true })
set("SnacksPickerBorder",     { fg = c.primary, bg = c.cursorline })
set("SnacksPickerMatch",      { fg = c.secondary, bold = true })

-- >> EXPLORER <<
set("SnacksExplorerDir",      { fg = c.primary, bold = true })
set("SnacksExplorerFolder",   { fg = c.secondary })
set("NvimTreeFolderIcon",     { fg = c.secondary })

-- >> GIT <<
set("GitSignsAdd",            { fg = c.secondary, bg = "NONE" })
set("GitSignsChange",         { fg = c.tertiary, bg = "NONE" }) 
set("GitSignsDelete",         { fg = c.error, bg = "NONE" })

-- >> BUSCA <<
set("Search",                 { fg = c.secondary, bg = c.selection, bold = true })
set("IncSearch",              { fg = c.background, bg = c.secondary, bold = true })

-- ============================================================
-- >> WHICH KEY (ADICIONADO AGORA) <<
-- ============================================================
-- A tecla (ex: <space>, f, g) fica com a cor Primária
set("WhichKey",          { fg = c.primary, bold = true }) 

-- Os grupos (ex: +file, +git) ficam com a cor Secundária
set("WhichKeyGroup",     { fg = c.secondary }) 

-- A descrição do comando fica com texto normal para leitura
set("WhichKeyDesc",      { fg = c.foreground }) 

-- A setinha "->" fica sutil
set("WhichKeySeparator", { fg = c.tertiary }) 

-- Fundo e Borda da janela flutuante
set("WhichKeyFloat",     { bg = c.cursorline }) 
set("WhichKeyBorder",    { fg = c.primary, bg = c.cursorline }) 

-- ============================================================
-- >> ÍCONES <<
-- ============================================================
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
