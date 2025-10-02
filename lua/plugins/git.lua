-- lua/plugins/git.lua
return {
  -- Signos en el margen + blame en línea
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,                -- blame en línea (virtual text)
      current_line_blame_opts = {
        delay = 400,                             -- ms
        virt_text = true,
        virt_text_pos = "eol",
        ignore_whitespace = false,
      },
      -- Formato del blame (autor, hace cuánto, resumen)
      current_line_blame_formatter = "<author> • <author_time:%Y-%m-%d %H:%M> • <summary>",
      -- Mapea acciones útiles
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Git Next Hunk")
        map("n", "[h", gs.prev_hunk, "Git Prev Hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame (popup)")
        map("n", "<leader>ht", gs.toggle_current_line_blame, "Toggle Inline Blame")
      end,
    },
  },

  -- Diffs e historial en vistas dedicadas
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Interfaz de git al estilo Magit (o usa fugitive si prefieres)
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    opts = {
      integrations = { diffview = true },
      kind = "tab", -- abre en nueva tab
    },
  },

  -- Telescope pickers de git (opcional pero 🔥)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function() return {} end,
  },

  -- Octo para PRs/Issues de GitHub (opcional)
  { "pwntester/octo.nvim", cmd = "Octo", dependencies = { "nvim-lua/plenary.nvim" } },
}
