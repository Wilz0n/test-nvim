return {
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server", -- se asegura que live-server esté instalado
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
    opts = {
      port = 5500, -- puerto por defecto
      -- root = ".", -- carpeta raíz (puedes cambiarla si tu html está en src/ por ejemplo)
    },
  },
}
