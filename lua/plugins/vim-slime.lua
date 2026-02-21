return {
  {
    "jpalardy/vim-slime",
    init = function()
      -- Usar terminal interna de Neovim
      vim.g.slime_target = "neovim"

      -- Configuración por defecto
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }

      -- Atajo principal (como VS Code)
      vim.g.slime_no_mappings = true
    end,
    keys = {
      { "<leader>r", "<Plug>SlimeRegionSend", mode = "v",               desc = "Run selection (slime)" },
      { "<leader>r", "<Plug>SlimeLineSend",   desc = "Run line (slime)" },
    },
  },
}
