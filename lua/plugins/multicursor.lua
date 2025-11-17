return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy", -- Bom uso de evento para carregamento tardio
  dependencies = {
    'nvimtools/hydra.nvim', -- Mantendo a dependência
  },

  opts = {}, -- Pode ser preenchido se precisar de configurações globais
  cmd = { 'MCstart', 'MCclear', 'MCUp', 'MCDown' }, -- Adicionei Up/Down aos comandos
  keys = {
    -- 1. VS Code: Alt + Down (Adicionar Cursor Abaixo)
    {
      mode = { 'n', 'i' },
      '<M-Down>',
      '<cmd>MCDown<cr>',
      desc = 'Multicursor: Adicionar cursor abaixo (Alt+Down)',
    },

    -- 2. VS Code: Alt + Up (Adicionar Cursor Acima)
    {
      mode = { 'n', 'i' },
      '<M-Up>',
      '<cmd>MCUp<cr>',
      desc = 'Multicursor: Adicionar cursor acima (Alt+Up)',
    },

    -- 3. VS Code: Ctrl + D (Adicionar Próxima Ocorrência)
    {
      mode = { 'n', 'v' },
      '<C-d>',
      '<cmd>MCstart<cr>',
      desc = 'Multicursor: Adicionar próxima ocorrência (Ctrl+D)',
    },

    -- 4. VS Code: Esc (Sair do Modo Multicursor)
    {
      mode = { 'n'},
      '<Esc>',
      '<cmd>MCclear<cr>',
      desc = 'Multicursor: Sair do modo',
    },
  },
}
