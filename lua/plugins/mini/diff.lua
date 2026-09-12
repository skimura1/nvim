--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")

MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full Page New Tab" })
-- <leader>gd is the LSP "go to definition" map in plugins/lsp.lua
vim.keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split" })
