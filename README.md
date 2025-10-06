# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Codigo-para: ui-transparency.lua:
´´´
-- plugins/ui-transparency.lua
-- Transparencia para LazyVim con Tokyonight + toggle
return {
{
"folke/tokyonight.nvim",
lazy = false,
priority = 1000,
opts = {
transparent = true,
styles = { sidebars = "transparent", floats = "transparent" },
},
config = function(\_, opts)
-- 1) Tema base
vim.opt.termguicolors = true
require("tokyonight").setup(opts)
vim.cmd.colorscheme("tokyonight")

      -- 2) Utilidades
      local set_hl = vim.api.nvim_set_hl
      local get_hl = vim.api.nvim_get_hl
      local aucmd = vim.api.nvim_create_autocmd

      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "LineNr",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "Pmenu",
        "PmenuSel",
        "CmpPmenu",
        "CmpPmenuBorder",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
        "TelescopePreviewNormal",
        "WhichKeyFloat",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NoicePopup",
        "NoicePopupmenu",
        "NotifyBackground",
        "LazyNormal",
      }

      local function apply(opts_tbl)
        for _, g in ipairs(groups) do
          pcall(set_hl, 0, g, opts_tbl)
        end
      end

      local function make_transparent()
        apply({ bg = "none", ctermbg = "NONE" })
      end

      -- 3) Aplicación tras cargar esquema / UI / VeryLazy
      aucmd({ "ColorScheme", "UIEnter" }, { callback = make_transparent })
      aucmd("User", { pattern = "VeryLazy", callback = make_transparent })

      -- 4) Toggle: <leader>ut
      vim.keymap.set("n", "<leader>ut", function()
        local normal = get_hl(0, { name = "Normal", link = false }) or {}
        local is_transparent = (not normal.bg) or normal.bg == 0
        if is_transparent then
          -- restaura tema (vuelve a fondo del tema)
          vim.cmd.colorscheme("tokyonight")
        else
          -- vuelve a transparente
          make_transparent()
        end
      end, { desc = "UI: Toggle Transparency" })
    end,

},

-- Opcional: para limpiar grupos rebeldes si alguna vez lo necesitas
{
"xiyaowong/transparent.nvim",
lazy = true,
opts = {
extra_groups = {
"NormalFloat",
"FloatBorder",
"NormalNC",
"CursorLine",
"CursorLineNr",
"LineNr",
"SignColumn",
"StatusLine",
"TelescopeNormal",
"TelescopeBorder",
"TelescopePromptNormal",
"TelescopeResultsNormal",
"TelescopePreviewNormal",
"NeoTreeNormal",
"NeoTreeNormalNC",
"WhichKeyFloat",
"CmpPmenu",
"CmpPmenuBorder",
"NoicePopup",
"NoicePopupmenu",
"NotifyBackground",
"LazyNormal",
},
exclude_groups = {},
},
},
}
´´´
