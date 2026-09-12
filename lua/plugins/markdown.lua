require("render-markdown").setup({
    heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    code = {
        sign = false,
        width = "block",
        right_pad = 1,
    },
    checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
    },
})

vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
