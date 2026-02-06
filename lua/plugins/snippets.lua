-- ~/.config/nvim/lua/plugins/snippets.lua
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- opcional, aporta muchos snippets base
    },
    config = function()
      local ls = require("luasnip")

      -- Cargar snippets de VSCode (friendly-snippets) si quieres
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Cargar TUS snippets en Lua desde esta carpeta:
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })

      -- Keymaps cómodos para expandir y moverte por los placeholders
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- Opcional: elegir opción en nodos con elecciones
      vim.keymap.set("i", "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
