-- 📦 Plugin: 3rd/image.nvim
-- 🧩 Permite visualizar imágenes directamente en Neovim
-- ⚙️ Requisitos para Ubuntu + Kitty:
-- 1️⃣ Instala el terminal Kitty y dependencias opcionales:
--     sudo apt install kitty chafa imagemagick
-- 2️⃣ Abre Neovim desde Kitty (importante):
--     kitty
--     nvim
-- 3️⃣ Ejecuta :Lazy sync para asegurar que el plugin esté instalado
-- 4️⃣ Abre un archivo .md con una imagen local, por ejemplo:
--     ![Ejemplo](~/ruta/a/tu/imagen.png)
-- ✅ Listo, las imágenes se renderizarán en la terminal

return {
  "3rd/image.nvim",
  event = "VeryLazy", -- 🔹 se carga siempre al iniciar
  opts = {
    backend = "kitty", -- 🔹 usa Kitty como backend (debe estar ejecutándose)
    integrations = {
      markdown = { enabled = true }, -- 🔹 habilita imágenes en archivos Markdown
      neorg = { enabled = true }, -- 🔹 habilita imágenes en Neorg (opcional)
    },
    max_width = 100, -- 🔹 ancho máximo de las imágenes
    max_height = 50, -- 🔹 alto máximo de las imágenes
  },
}
