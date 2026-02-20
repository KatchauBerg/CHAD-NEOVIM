return {
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick",
    },
    opts = {
      backend = "kitty", -- Força o uso do protocolo Kitty
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },
      max_width = 100, 
      max_height = 12, -- Ajuste para não ocupar a tela toda
      max_width_window_percentage = nil, 
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, 
      editor_only_render_when_focused = false, 
      tmux_show_only_in_active_window = true, 
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, 
    },
  },
}
