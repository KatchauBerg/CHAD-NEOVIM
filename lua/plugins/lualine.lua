return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- Carrega o nosso arquivo de tema
    local matugen_theme = require("config.matugen_lualine")
    
    return {
      options = {
        -- APLICA O TEMA AQUI
        theme = matugen_theme,
        
        -- Configurações visuais para combinar (Bolhas/Rounded)
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      -- ... resto da sua configuração de seções ...
    }
  end,
}
