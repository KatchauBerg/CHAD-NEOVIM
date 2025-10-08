return {
  bigfile = { enabled = false },
  -- dashboard = { enabled = true,
  --   sections = {
  --     {
  --       { section = "header" },
  --       { section = "keys", gap = 1, padding = 1 },
  --       { section = "startup" },
  --       {
  --         section = "terminal",
  --         cmd = "ascii-image-converter $HOME/.config/nvim/images/giphy.gif -C -c",
  --         random = 10,
  --         pane = 2,
  --         indent = 4,
  --         height = 30,
  --       },
  --     },
  --   },
  -- }, 
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    }
  }
}
