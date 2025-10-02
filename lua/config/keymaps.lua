local map = vim.keymap.set 
local opts = function (desc)
return {
    noremap = true, silent = true, desc = desc
}
end

-- keymaps personales para inicio comun
map ("n", "<C-s>", "<cmd>w<cr>", opts("guardar archivos oh cambios"))
map ("n", "<leader>q", "<cmd>bd<cr>", opts("cerrar buffer"))
map("v", "J", ":m '>+1<CR>gv=gv", opts())
map("v", "K", ":m '<-2<CR>gv=gv", opts())
map("x", "<leader>p", '"_dP', opts())

-- Keympas de GIT

-- Gitsigns toggle blame inline
vim.keymap.set("n", "<leader>gb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle inline blame" })

-- Blame popup (muestra autor, mail, fecha, resumen y hash)
vim.keymap.set("n", "<leader>gB", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git: Blame popup" })

-- Diffview
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git: Diffview Open" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git: File History (buffer)" })
vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Git: Repo History" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Git: Neogit" })

-- Telescope git pickers
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git: Commits" })
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>", { desc = "Git: Buffer Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git: Status" })
vim.keymap.set("n", "<leader>gbb","<cmd>Telescope git_branches<CR>", { desc = "Git: Branches" })
