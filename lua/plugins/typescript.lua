-- lua/plugins/typescript.lua
return {
  -- Herramientas TS/JS modernas (más pulido que tsserver "crudo")
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      -- "hrsh7th/cmp-nvim-lsp", -- para que nvim-cmp use el LSP
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      -- Capacidades para integrarse con nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("typescript-tools").setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Si formateas con prettier/eslint, desactiva el format del server:
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Mapeos útiles (opcionales)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map("n", "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", "TS: Organize Imports")
          map("n", "<leader>tr", "<cmd>TSToolsRemoveUnused<CR>",   "TS: Remove Unused")
          map("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<CR>", "TS: Add Missing Imports")
        end,
        settings = {
          -- Habilita autocierre de etiqueta JSX/TSX
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
          -- Si prefieres usar vtsls (mejores inlay hints/refactors):
          tsserver = {
            -- Puedes forzar el binario de TS si lo tienes en proyecto:
            -- path = vim.fn.getcwd() .. "/node_modules/typescript/lib/tsserver.js",
          },
          -- Opciones para vtsls
          vtsls = {
            enabled = true, -- usa @vtsls/language-server si está instalado
            experimental = {
              completion = { enableServerSideFuzzyMatch = true },
            },
          },
          -- Preferencias de TypeScript/JS
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            preferences = {
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
            },
          },
        },
      })
    end,
  },

  -- Treesitter: sintaxis/AST para JS/TS/TSX (muy recomendable)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "javascript", "typescript", "tsx",
        "json", "html", "css", "lua", "vim", "vimdoc"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Autocierre de pares y tags en React/TSX (opcional pero top)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact" },
    config = true,
  },
}
