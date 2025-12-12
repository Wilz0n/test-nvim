-- 📦 Plugin: 3rd/image.nvim
-- 🧩 Permite visualizar imágenes directamente en Neovim
-- ⚙️ Requisitos para archlinux + fish:
-- 1️⃣ Instala el terminal Kitty y dependencias opcionales:
-- sudo pacman -S ueberzugpp imagemagick chafa openslide libvips
-- 2️⃣ Abre Neovim desde Kitty (importante):
-- fish
-- nvim
-- 3️⃣ Ejecuta ":Lazy sync" para asegurar que el plugin esté instalado
-- 4️⃣ Abre un archivo .md con una imagen local, por ejemplo:
-- ![Ejemplo](~/ruta/a/tu/imagen.png)
-- ✅ Listo, las imágenes se renderizarán en la terminal

return {
"3rd/image.nvim",
event = "VeryLazy",
opts = {
backend = "ueberzug",
backend_options = {
ueberzugpp = {
wayland = true,
},
},
integrations = {
markdown = { enabled = true },
neorg = { enabled = true },
},
max_width = 100,
max_height = 50,
},
}
