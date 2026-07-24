vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

local TASKS_DIR = "/Users/skyler/notes/project_tasks"

vim.api.nvim_create_user_command("TodoNew", function(opts)
    local date_key = os.date("%m%d%Y")
    local title = opts.args ~= "" and opts.args or os.date("%B %d, %Y")
    local output = TASKS_DIR .. "/daily/" .. date_key .. ".md"

    if vim.fn.filereadable(output) == 1 then
        vim.cmd.edit(output)
        return
    end

    local template = vim.fn.readfile(TASKS_DIR .. "/templates/daily.md")
    local lines = {}
    for _, line in ipairs(template) do
        table.insert(lines, (line:gsub("{{title}}", title)))
    end
    vim.fn.writefile(lines, output)
    vim.cmd.edit(output)
end, { nargs = "?", desc = "Create or open today's daily todo (:TodoNew [title])" })

vim.keymap.set("n", "<leader>tn", "<cmd>TodoNew<cr>", { desc = "Today's todo" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	-- checks if any argument is passed
    if opts.args:match("%S") then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		-- update only specified plugins
        vim.pack.update(plugins)
    else
        -- update all
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })
