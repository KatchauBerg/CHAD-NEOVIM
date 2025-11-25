vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "matugen"

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
-- 3. MAPEAMENTO COMPLETO
-- ============================================================

-- >> BASE (TRANSPARÊNCIA) <<
set("Normal",       { fg = c.foreground, bg = "NONE" })
set("NormalNC",     { fg = c.foreground, bg = "NONE" })
set("SignColumn",   { bg = "NONE" }) 
set("LineNr",       { fg = c.comment, bg = "NONE" })
set("CursorLineNr", { fg = c.primary, bold = true, bg = "NONE" })
set("VertSplit",    { fg = c.border, bg = "NONE" })
set("WinSeparator", { fg = c.border, bg = "NONE" })
set("CursorLine",   { bg = c.cursorline })
set("Visual",       { bg = c.selection })

-- >> ELEMENTOS DE CÓDIGO <<
set("Comment",      { fg = c.comment, italic = true })
set("String",       { fg = c.tertiary }) 
set("Number",       { fg = c.secondary })
set("Boolean",      { fg = c.secondary, bold = true })
set("Float",        { fg = c.secondary })
set("Character",    { fg = c.tertiary })
set("Keyword",      { fg = c.secondary, italic = true }) 
set("Statement",    { fg = c.secondary })
set("Conditional",  { fg = c.secondary })
set("Repeat",       { fg = c.secondary })
set("Operator",     { fg = c.foreground })
set("Type",         { fg = c.primary }) 
set("Function",     { fg = c.primary, bold = true }) 
set("Identifier",   { fg = c.foreground }) 

-- >> TREESITTER <<
set("@variable",           { fg = c.foreground }) 
set("@variable.builtin",   { fg = c.secondary, italic = true }) 
set("@variable.parameter", { fg = c.tertiary, italic = true })  
set("@variable.member",    { fg = c.foreground }) 
set("@punctuation.delimiter", { fg = c.secondary }) 
set("@punctuation.bracket",   { fg = c.foreground }) 
set("@constructor",    { fg = c.primary }) 
set("@property",       { fg = c.foreground }) 
set("@field",          { fg = c.foreground })
set("@keyword.function", { fg = c.secondary, italic = true }) 
set("@keyword.return",   { fg = c.secondary, italic = true })
set("@tag",           { fg = c.primary })
set("@tag.attribute", { fg = c.tertiary, italic = true })
set("@tag.delimiter", { fg = c.secondary })

-- >> UI FLUTUANTE <<
set("NormalFloat",  { fg = c.foreground, bg = c.cursorline })
set("FloatBorder",  { fg = c.primary, bg = c.cursorline })
set("Pmenu",        { fg = c.foreground, bg = c.cursorline })
set("PmenuSel",     { fg = c.background, bg = c.primary, bold = true })
set("TelescopeNormal", { link = "NormalFloat" })
set("TelescopeBorder", { link = "FloatBorder" })

-- >> GIT & DIAGNOSTICS <<
set("Added",           { fg = c.primary })
set("Modified",        { fg = c.tertiary })
set("Deleted",         { fg = c.error })
set("DiagnosticError", { fg = c.error })
set("DiagnosticWarn",  { fg = c.warn })
set("DiagnosticInfo",  { fg = c.primary })
set("DiagnosticHint",  { fg = c.comment })

-- >> SNACKS DASHBOARD <<
set("SnacksDashboardHeader",  { fg = c.primary, bold = true })
set("SnacksDashboardIcon",    { fg = c.secondary })
set("SnacksDashboardKey",     { fg = c.tertiary, bold = true })
set("SnacksDashboardDesc",    { fg = c.foreground })
set("SnacksDashboardFooter",  { fg = c.tertiary, italic = true }) 
set("SnacksDashboardSpecial", { fg = c.secondary }) 
set("SnacksDashboardFile",    { fg = c.foreground })
set("SnacksDashboardDir",     { fg = c.comment })
set("SnacksPickerInputTitle", { fg = c.background, bg = c.primary, bold = true })
set("SnacksPickerInput",      { fg = c.foreground, bg = c.cursorline })
set("SnacksPickerBorder",     { fg = c.primary, bg = c.cursorline })
set("SnacksPickerList",       { fg = c.foreground, bg = c.cursorline })

-- ============================================================
-- >> CORREÇÃO DAS PASTAS (EXPLORER) << 
-- ============================================================
-- ADICIONEI ESTE BLOCO QUE ESTAVA FALTANDO:

-- 'Directory' controla a cor do nome da pasta em todo o Neovim
set("Directory", { fg = c.primary, bold = true })

-- Ícones de pasta (para Snacks Explorer / NvimTree)
set("SnacksExplorerDir",    { fg = c.primary, bold = true })
set("SnacksExplorerFolder", { fg = c.secondary })
set("NvimTreeFolderIcon",   { fg = c.secondary })
set("NvimTreeFolderName",   { fg = c.primary })

-- ============================================================
-- >> ÍCONES (DEVICONS + MINI.ICONS) <<
-- ============================================================

-- 1. Mini.Icons (Usado pelo Snacks)
set("MiniIconsAzure",  { fg = c.secondary })
set("MiniIconsBlue",   { fg = c.secondary })
set("MiniIconsCyan",   { fg = c.secondary })
set("MiniIconsGreen",  { fg = c.secondary })
set("MiniIconsGrey",   { fg = c.secondary })
set("MiniIconsOrange", { fg = c.secondary })
set("MiniIconsPurple", { fg = c.secondary })
set("MiniIconsRed",    { fg = c.secondary })
set("MiniIconsYellow", { fg = c.secondary })

-- 2. DevIcons (Legacy e NvimTree)
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

vim.api.nvim_create_autocmd("User", {
    pattern = "WebDevIconsLoaded",
    callback = paint_icons,
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(paint_icons)
    end
})

-- ============================================================
-- >> INDENTATION GUIDES (LINHAS DE GUIA) <<
-- ============================================================

-- Linhas passivas (as que estão lá só para guiar o olhar)
-- Vamos usar a cor de 'comentário' para ficarem sutis e não distraírem.
set("SnacksIndent",       { fg = c.comment }) 
set("SnacksIndentChunk",  { fg = c.comment })

-- Linha do Escopo Atual (Onde seu cursor está digitando)
-- Vamos usar a cor Primária ou Secundária para destacar o bloco atual.
set("SnacksIndentScope",  { fg = c.primary }) 

-- ============================================================
-- Compatibilidade com indent-blankline (IBL)
-- (Caso você decida trocar o Snacks por IBL no futuro, já fica pronto)
set("IblIndent",      { fg = c.comment })
set("IblScope",       { fg = c.primary })
set("IblWhitespace",  { fg = c.comment })
