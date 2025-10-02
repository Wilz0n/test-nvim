-- ~/.config/nvim/lua/plugins/image.lua
return {
  "3rd/image.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("image").setup({
      backend = "kitty",  -- usa el protocolo gráfico de kitty
      integrations = {
        markdown = {
          enabled = true,                -- ver imágenes en .md
          clear_in_insert_mode = true,   -- borra preview al escribir
          download_remote_images = true, -- soporta URLs http/https
          only_render_image_at_cursor = false,
        },
        neorg = { enabled = false },
        typst = { enabled = false },
        html = { enabled = false },
      },
      max_width = 80,          -- ancho máximo en columnas
      max_height = 40,         -- alto máximo en filas
      max_width_window_percentage = 50,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = true,
      editor_only_render_when_focused = true,
    })
  end,
}

