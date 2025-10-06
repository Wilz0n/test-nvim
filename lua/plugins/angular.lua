return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("angular.json", "workspace.json", "nx.json")(fname)
              or util.root_pattern("project.json")(fname)
          end,
          filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
          on_new_config = function(new_config, _)
            new_config.cmd = {
              "ngserver",
              "--stdio",
              "--tsProbeLocations",
              "",
              "--ngProbeLocations",
              "",
            }
          end,
        },
      },
    },
  },
}
