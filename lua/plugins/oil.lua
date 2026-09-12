local oil = require("oil")

oil.setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
    win_options = {
        -- oil-git-status needs two sign columns: index status on the left,
        -- working-tree status on the right (same order as `git status --short`)
        signcolumn = "yes:2",
    },
    keymaps = {
        -- carried over from the mini.files setup this replaced
        ["<CR>"] = "actions.select",
        ["L"] = "actions.select",
        ["_"] = "actions.parent",
        ["H"] = "actions.parent",
    },
})

require("oil-git-status").setup()

-- open at the current file's directory, falling back to cwd for unnamed buffers
vim.keymap.set("n", "-", function()
    oil.open()
end, { desc = "Open file explorer at current file" })

vim.keymap.set("n", "<leader>-", function()
    oil.open(vim.fn.getcwd())
end, { desc = "Open file explorer at cwd root" })
