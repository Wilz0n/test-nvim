-- 📦 Plugin: 3rd/image.nvim
-- 🧩 Permite visualizar imágenes directamente en Neovim
-- ⚙️ Requisitos para Ubuntu + Kitty:
-- 1️⃣ Instala el terminal Kitty y dependencias opcionales (Mencionar que en omarchy ya lo tiene predeterminadamente instalado):
--     sudo apt install kitty chafa imagemagick
-- 2️⃣ Abre Neovim desde Kitty (importante):
--     Ghostty
--       o
--     kitty
--     nvim
-- 3️⃣ Ejecuta :Lazy sync para asegurar que el plugin esté instalado
-- 4️⃣ Abre un archivo .md con una imagen local, por ejemplo:
--     ![Ejemplo](~/ruta/a/tu/imagen.png)
-- ✅ Listo, las imágenes se renderizarán en la terminal
-- Codigo actualizado para soporte en Ghostty y con el protocolo nativo de kitty

return {
  "3rd/image.nvim",
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = false,
      },
      neorg = { enabled = true },
    },
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },

    max_width = 100,
    max_height = 40,

    window_overlap_clear_enabled = true,
    editor_only_render_when_focused = false,
  },
}
