local map = vim.keymap.set 
local opts = function (desc)
return {
    noremap = true, silent = true, desc = desc
}
end

map ("n", "<C-s>", "<cmd>w<cr>", opts("guardar archivos oh cambios"))
map ("n", "<leader>q", "<cmd>bd<cr>", opts("cerrar buffer"))
map("v", "J", ":m '>+1<CR>gv=gv", opts())
map("v", "K", ":m '<-2<CR>gv=gv", opts())
map("x", "<leader>p", '"_dP', opts())