require("mini.statusline").setup({
    use_icons = true, -- backed by mini.icons, set up in plugins/mini/icons.lua
})

-- mini.statusline already renders the mode, so the builtin one is duplication
vim.opt.showmode = false
