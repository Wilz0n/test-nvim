return {
  {
    -- 🔹 Muestra quién cambió cada línea y cuándo
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
      },
      -- Activa el blame virtual (comentario del commit sobre la línea)
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 400, -- milisegundos antes de aparecer
        virt_text = true,
        virt_text_pos = "eol",
        ignore_whitespace = false,
      },
      -- Formato del texto mostrado al final de la línea
      current_line_blame_formatter = "<author> • <author_time:%Y-%m-%d %H:%M> • <summary>",
    },
  },

  {
    -- 🔹 Permite abrir historial visual de commits
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
