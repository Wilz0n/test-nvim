# Ghostty configuración (imágenes en Neovim + tmux)

Guía para que **Neovim (LazyVim)** muestre imágenes dentro del editor usando **Ghostty**, también dentro de **tmux**, sobre Omarchy.

> ⚠️ Importante: Omarchy puede tener como terminal por defecto **foot**, que **no** soporta el protocolo gráfico de kitty.
> Si al abrir una imagen en nvim ves `terminal does not support the kitty graphics protocol`, estás en foot (o en otra terminal sin soporte).


## 1. Poner Ghostty como terminal por defecto

### Cambiar el terminal de Omarchy (afecta a `Super + Enter`)

```bash
omarchy default terminal ghostty
```

Esto escribe `~/.config/xdg-terminals.list` con `com.mitchellh.ghostty.desktop`. Después **abrir una terminal nueva**.

### Comprobar en qué terminal estás

```bash
echo $TERM            # en Ghostty debe salir: xterm-ghostty
ps -o comm= -p $(ps -o ppid= -p $$)   # muestra el proceso padre (ghostty / foot / ...)
```


## 2. Configuración de Ghostty

### Ruta: `~/.config/ghostty/config`

Ghostty soporta el protocolo gráfico de kitty **de serie**, no hay que activarlo. Solo se añadió al final del archivo el límite de memoria para imágenes:

```javascript
# Imágenes en terminal (protocolo gráfico de kitty), usado por Neovim (snacks.image)
# Ghostty lo soporta de serie; aquí se fija el límite de memoria para imágenes (por pantalla).
image-storage-limit = 320000000
```

### Validar y recargar

```bash
ghostty +validate-config
omarchy restart terminal
```


## 3. Imágenes en Neovim (snacks.image)

Antes se usaba `3rd/image.nvim`, pero necesita la librería `magick` de luarocks. Ahora se usa **`snacks.image`**, que ya viene con LazyVim, no necesita nada extra y detecta tmux solo.

### Requisitos (Omarchy ya los trae)

- Ghostty (o kitty / wezterm)
- ImageMagick (`magick`) para convertir formatos
- Opcional: `ghostscript` (PDF), `tectonic` o `pdflatex` (fórmulas LaTeX), `mermaid-cli` (diagramas)

### Ruta: `~/.config/nvim/lua/plugins/image.lua`

```lua
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true, -- dibujar la imagen dentro del buffer
        float = true, -- si no se puede inline, usar ventana flotante
        max_width = 100,
        max_height = 40,
      },
    },
  },
  keys = {
    {
      "<leader>ui",
      function()
        Snacks.image.hover()
      end,
      desc = "Ver imagen bajo el cursor",
    },
  },
}
```

### Uso

- Abrir un `.png / .jpg / .gif / .webp ...` (por ejemplo desde Neo-tree) lo muestra como imagen.
- En Markdown, `![alt](ruta/imagen.png)` se dibuja debajo de la línea.
- `<leader>ui` → imagen bajo el cursor en ventana flotante.
- Diagnóstico: `:checkhealth snacks` (sección **image**).


## 4. Imágenes dentro de tmux

tmux tiene que dejar pasar las secuencias gráficas hacia Ghostty. En `~/.config/tmux/tmux.conf`:

```javascript
# --- Imágenes en Neovim dentro de tmux (Ghostty / kitty) ---
# Deja pasar el protocolo gráfico de kitty hacia Ghostty.
set -g allow-passthrough on
# Evita que tmux muestre avisos que tapan/borran las imágenes.
set -g visual-activity off
# Pasa a Neovim qué terminal hay fuera de tmux (para detectar Ghostty).
set -ga update-environment " TERM TERM_PROGRAM"
```

Recargar: `prefijo + q`, o cerrar tmux por completo (`tmux kill-server`) y volver a abrirlo **desde Ghostty**.


## 5. Cambios en Neovim (fusión con la base nueva de Omarchy)

Se mantuvo la base nueva de Omarchy en `~/.config/nvim` (temas, recarga de tema, transparencia, portapapeles remoto, lualine transparente) y se añadió lo personal de esta rama:

| Archivo | Qué hace |
|---|---|
| `lua/config/keymaps.lua` | Atajos personales (`<leader>q`, `<leader>sv`, `<leader>sh`, flechas entre ventanas, `<leader>w=`, `<leader>wc`) |
| `lua/config/options.lua` | Se añadió `vim.g.root_spec = { "cwd" }` |
| `lua/plugins/dash.lua` | Dashboard con el logo WILNUX |
| `lua/plugins/github.lua` | gitsigns con blame en línea + diffview |
| `lua/plugins/image.lua` | Imágenes con snacks.image (ver punto 3) |
| `lua/plugins/linting.lua` | nvim-lint con `squawk` para SQL (Mason lo instala solo) |
| `lua/plugins/live-server.lua` | Live Server en el puerto 5500 |
| `lua/plugins/render-markdown.lua` | Estilo de render de Markdown |
| `lua/plugins/snippets.lua` | LuaSnip + friendly-snippets + tus snippets en `~/.config/nvim/snippets/` |
| `lua/plugins/telescope.lua` | `<leader>fw` buscar palabra en todo el proyecto |
| `lua/plugins/vim-slime.lua` | `<leader>r` enviar línea/selección a la terminal |

### Extras de LazyVim (en `lazyvim.json`)

Los archivos `angular.lua`, `astro.lua` y `tailwind.lua` **ya no se copian**: con Neovim 0.12 la forma antigua de configurar el LSP de Angular (`root_dir(fname)` + `on_new_config`) deja de funcionar. Se reemplazaron por los extras oficiales:

```json
{
  "extras": [
    "lazyvim.plugins.extras.editor.neo-tree",
    "lazyvim.plugins.extras.coding.luasnip",
    "lazyvim.plugins.extras.lang.angular",
    "lazyvim.plugins.extras.lang.astro",
    "lazyvim.plugins.extras.lang.markdown",
    "lazyvim.plugins.extras.lang.tailwind",
    "lazyvim.plugins.extras.lang.typescript"
  ]
}
```

También se pueden activar/desactivar desde nvim con `:LazyExtras`.

### Aplicar

```bash
nvim
:Lazy sync
:Mason        # espera a que terminen de instalarse los LSP la primera vez
```

> Nota: en buffers con LSP, LazyVim usa `<C-k>` en modo insert para la ayuda de firma, que tiene prioridad sobre el `<C-k>` de LuaSnip.


## 6. Cambios en tmux (`~/.config/tmux/tmux.conf`)

Se fusionó la configuración nueva de Omarchy con la de `tmux-config.md`:

- Prefijo **`Ctrl + s`** (`Ctrl + b` sigue como prefijo secundario).
- `prefijo + h/j/k/l` → moverse entre paneles estilo Vim.
- Como `h` y `k` ahora son navegación: dividir con **`prefijo + s`** (vertical) y **`prefijo + v`** (horizontal), cerrar ventana con **`prefijo + X`**.
- Se mantienen los atajos de Omarchy: `Alt + Enter` / `Alt + Shift + Enter` dividir, `Alt + 1..9` ventanas, `prefijo + ?` lista de atajos.
- Barra abajo con el tema naranja estilo gruvbox/LazyVim, números de ventana en kanji y fecha/hora.
- Ajustes para imágenes (punto 4).

> ⚠️ Sobre "Oh My Tmux!" (`~/.tmux.conf`): si existe `~/.tmux.conf`, tmux **ignora** `~/.config/tmux/tmux.conf`. Por eso no se instaló; todo está en `~/.config/tmux/tmux.conf`.


## 7. Respaldo

Antes de los cambios se guardó una copia de `nvim`, `tmux` y `ghostty` en:

```bash
~/.config/backup-nvim-tmux-20261103-232038/
```


## 8. Problemas comunes

| Síntoma | Solución |
|---|---|
| `terminal does not support the kitty graphics protocol` | No estás en Ghostty → `omarchy default terminal ghostty` y abre una terminal nueva |
| Funciona fuera de tmux pero no dentro | Recarga tmux o `tmux kill-server` y ábrelo desde Ghostty |
| No se ven imágenes en Markdown | Revisa `:checkhealth snacks` (necesita el parser treesitter de markdown) |
| Formatos raros (svg, pdf, heic...) no salen | Instala ImageMagick / ghostscript |
