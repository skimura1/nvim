require("godoc").setup({})
require("gopher").setup({})

local function toggle_go_test()
	local path = vim.fn.expand("%:p")
	local target

	if path:match("_test%.go$") then
		target = path:gsub("_test%.go$", ".go")
	elseif path:match("%.go$") then
		target = path:gsub("%.go$", "_test.go")
	else
		return
	end

	vim.cmd.edit(vim.fn.fnameescape(target))
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function(ev)
		vim.keymap.set("n", "<leader>gt", toggle_go_test, {
			buffer = ev.buf,
			desc = "Toggle Go test/implementation",
		})
	end,
})

vim.keymap.set("n", "<leader>god", "<cmd>GoDoc<CR>", { silent = true, desc = "Go docs" })
