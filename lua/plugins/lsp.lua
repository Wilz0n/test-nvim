return {
  -- =========================
  -- LSP + diagnósticos
  -- =========================
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp",                lazy = true },
      { "nvim-lua/plenary.nvim",               lazy = true },
      { "antosha417/nvim-lsp-file-operations", lazy = true, config = true },
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Keymaps por buffer cuando un LSP se adjunta
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local opts = { buffer = buf, silent = true, noremap = true, desc = "Hover LSP" }
          -- <leader>K -> Hover (explicación). Úsalo sobre clases Tailwind: flex, flex-row, etc.
          vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)
        end,
      })

      local function setup_lsp_servers(servers)
        for server, config in pairs(servers) do
          local opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, config)
          vim.lsp.config(server, opts) -- Neovim 0.10+
        end
      end

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN]  = "Warn",
            [vim.diagnostic.severity.INFO]  = "Info",
            [vim.diagnostic.severity.HINT]  = "Hint",
          },
        },
        virtual_text = true,
      })

      setup_lsp_servers({
        vtsls       = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },
        astro       = { filetypes = { "astro" } },
        html        = { filetypes = { "html", "htm" } },
        cssls       = { filetypes = { "css", "scss", "less" } },

        -- ***** CAMBIO CLAVE: Tailwind en más filetypes *****
        tailwindcss = {
          filetypes = {
            "html", "htm",
            "css", "scss", "less",
            "javascript", "javascriptreact",
            "typescript", "typescriptreact",
            "astro",
            "vue",
            "svelte",
          },
        },

        marksman    = { filetypes = { "markdown" } },

        lua_ls      = {
          settings = {
            Lua = {
              workspace = {
                library = { "${3rd}/love2d/library" },
              },
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
          filetypes = { "lua" },
        },
      })
    end,
  },

  -- =========================
  -- Mason (gestiona LSPs)
  -- =========================
  {
    "mason-org/mason.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      lazy = true,
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "vtsls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "graphql",
          "astro",
          "marksman",
          "angularls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- =========================
  -- Formateo (Conform) -> COMENTADO
  -- =========================
  -- {
  --   "stevearc/conform.nvim",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local conform = require("conform")
  --     conform.setup({
  --       formatters_by_ft = {
  --         json = { "prettier" },
  --         javascript = { "prettier" },
  --         typescript = { "prettier" },
  --         javascriptreact = { "prettier" },
  --         typescriptreact = { "prettier" },
  --         astro = { "prettier" },
  --         css = { "prettier" },
  --         html = { "prettier" },
  --         markdown = { "prettier" },
  --         lua = { "stylua" },
  --         python = { "black" },
  --       },
  --       format_on_save = {
  --         lsp_fallback = true,
  --         async = false,
  --         timeout_ms = 500,
  --       },
  --     })
  --     vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  --       conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
  --     end, { desc = "Format file or range (in visual mode)" })
  --   end,
  -- },

  -- =========================
  -- Lint (nvim-lint)
  -- =========================
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        astro = { "eslint_d" },
        markdown = { "markdownlint" },
        python = { "pylint" },
      }

      local lint_autogroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function() lint.try_lint() end,
      })

      vim.keymap.set("n", "<leader>l", function() lint.try_lint() end, { desc = "Trigger linting for current file" })
      vim.keymap.set("n", "<leader>le", function()
        vim.diagnostic.enable()
        vim.notify("Linter enabled", vim.log.levels.INFO)
      end, { desc = "Linter enabled" })
      vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.disable()
        vim.notify("Linter disabled", vim.log.levels.INFO)
      end, { desc = "Linter disabled" })
    end,
  },
}
