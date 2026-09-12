require("grug-far").setup()

vim.keymap.set("n", "<leader>sr", function()
    require("grug-far").open()
end, { desc = "Search and Replace (grug-far)" })

vim.keymap.set("v", "<leader>sr", function()
    require("grug-far").with_visual_selection()
end, { desc = "Search and Replace visual selection (grug-far)" })
