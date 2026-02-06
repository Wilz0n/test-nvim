-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- config personal keymaps

local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- cerrar ventana actual con <leader> + q
map("n", "<leader>q", "<cmd>bd<cr>", opts("cerrar buffer"))

-- Dividir verticalmente
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Dividir ventana verticalmente" })

-- Dividir horizontalmente
map("n", "<leader>sh", ":split<CR>", { desc = "Dividir ventana horizontalmente" })

-- Moverse entre ventanas fácilmente
map("n", "<leader><Left>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<leader><Right>", "<C-w>l", { desc = "Ventana derecha" })
map("n", "<leader><Up>", "<C-w>k", { desc = "Ventana arriba" })
map("n", "<leader><Down>", "<C-w>j", { desc = "Ventana abajo" })

-- Ajustar tamaño
map("n", "<leader>w=", "<C-w>=", { desc = "Igualar tamaño de ventanas" })
map("n", "<leader>wc", "<cmd>close<CR>", { desc = "Cerrar ventana actual" })
