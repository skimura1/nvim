vim.g.netrw_banner = 0

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true

        vim.keymap.set("i", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]

            local indent, marker, content = line:match("^(%s*)([-*+] %[[ xX]%]) ?(.*)$")

            -- only continue the checklist when hitting enter at the end of the line
            if not indent or col < #line then
                return "\r"
            end

            if content == "" then
                -- empty item: clear it instead of carrying the checkbox forward
                return string.rep("\8", #line)
            end

            local checkbox_marker = marker:gsub("%[[ xX]%]", "[ ]")

            -- 'smartindent' copies `indent` onto the new line on its own; a
            -- single backspace clears all of it in one go (but only if it
            -- actually added any, else the backspace joins the lines instead)
            local clear_auto_indent = indent ~= "" and "\8" or ""
            return "\r" .. clear_auto_indent .. indent .. checkbox_marker .. " "
        end, { buffer = ev.buf, expr = true, desc = "Continue markdown checklist" })

        vim.keymap.set("n", "o", function()
            local line = vim.api.nvim_get_current_line()
            local indent, marker = line:match("^(%s*)([-*+] %[[ xX]%]) ?")

            if not indent then
                vim.cmd("normal! o")
                return
            end

            local checkbox_marker = marker:gsub("%[[ xX]%]", "[ ]")
            local new_line = indent .. checkbox_marker .. " "
            local row = vim.api.nvim_win_get_cursor(0)[1]

            vim.api.nvim_buf_set_lines(0, row, row, false, { new_line })
            vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
            vim.cmd.startinsert({ bang = true })
        end, { buffer = ev.buf, desc = "Open new markdown checklist line below" })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
