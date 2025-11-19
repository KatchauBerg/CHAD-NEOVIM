return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = "ToggleTerm",
  config = function()
    require('toggleterm').setup({
      -- Configurações globais
      size = 20,              -- Altura padrão do split horizontal
      open_mapping = [[<C-/>]], -- Mapeamento que será usado para alternar
      hide_numbers = true,    -- Oculta números de linha
      shade_terminals = true, -- Escurece um pouco a cor do terminal
      direction = 'float',    -- Direção padrão (pode ser 'horizontal', 'vertical' ou 'float')
      close_on_exit = true,   -- Fecha a janela quando o processo do terminal é encerrado
    })

    -- 2. Criação das Funções Globais para Toggle
    local term = require('toggleterm')

    -- Função para Terminal Flutuante
    function _G.set_float_term()
      term.toggle(1, 'float') -- ID 1 para o terminal flutuante
    end

    -- Função para Terminal Horizontal (Split)
    function _G.set_hsplit_term()
      term.toggle(2, 'horizontal') -- ID 2 para o terminal horizontal
    end

    -- Função para Terminal Vertical (Split)
    function _G.set_vsplit_term()
      term.toggle(3, 'vertical') -- ID 3 para o terminal vertical
    end

    -- 3. Mapeamento dos Atalhos de Teclado (Keymaps)
    local opts = { noremap = true, silent = true }
    local map = vim.keymap.set

    -- Mapeamento dos atalhos <Alt> + h/v/i no Modo Normal
    map('n', '<A-h>', '<cmd>lua set_hsplit_term()<CR>', opts)
    map('n', '<A-v>', '<cmd>lua set_vsplit_term()<CR>', opts)
    map('n', '<A-i>', '<cmd>lua set_float_term()<CR>', opts)

  end
}
