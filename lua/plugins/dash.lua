-- lua/plugins/dash.lua
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local logo = [[
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
██╗    ██╗██╗██╗     ███╗   ██╗██╗   ██╗██╗  ██╗
██║    ██║██║██║     ████╗  ██║██║   ██║╚██╗██╔╝
██║ █╗ ██║██║██║     ██╔██╗ ██║██║   ██║ ╚███╔╝ 
██║███╗██║██║██║     ██║╚██╗██║██║   ██║ ██╔██╗ 
╚███╔███╔╝██║███████╗██║ ╚████║╚██████╔╝██╔╝ ██╗
 ╚══╝╚══╝ ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝
                                                
                                                                
                                                                
]]

      logo = string.rep("\n", 2) .. logo .. "\n\n" -- usa 2-3 saltos, no 8

      local opts = {
        theme = "doom",
        hide = { statusline = false },
        config = {
          header = vim.split(logo, "\n", { trimempty = true }),
          center = {
            { action = "lua LazyVim.pick()()", desc = " Find File", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
            { action = 'lua LazyVim.pick("oldfiles")()', desc = " Recent Files", icon = " ", key = "r" },
            { action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", icon = " ", key = "g" },
            { action = "lua LazyVim.pick.config_files()()", desc = " Config", icon = " ", key = "c" },
            -- si no tienes persistence.nvim, comenta la línea de abajo
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      -- formateo bonito de los botones
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- abrir dashboard tras cerrar :Lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },

  -- Si tu LazyVim trae dashboard de Snacks, desactícalo o no verás cambios:
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      dashboard = { enabled = false },
    },
  },
}
