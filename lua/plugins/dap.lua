local dap = require("dap")

--- adapters ---
-- debugpy and delve come from mason (see plugins/lsp.lua `ensure_installed`).
local mason_bin = vim.fn.stdpath("data") .. "/mason/packages"

require("dap-python").setup(mason_bin .. "/debugpy/venv/bin/python")
require("dap-go").setup()

--- signs ---
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

--- keymaps ---
-- Control flow lives on the function keys: <leader>d is already taken twice
-- (delete-without-yank globally, LSP diagnostics float buffer-locally).
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: start/continue" })
vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: terminate" })
vim.keymap.set("n", "<F7>", dap.repl.toggle, { desc = "Debug: toggle REPL" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: step out" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: conditional breakpoint" })

-- Per-language test helpers, buffer-local so they don't crowd <leader>t globally.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(ev)
        local dap_python = require("dap-python")
        vim.keymap.set("n", "<leader>tm", dap_python.test_method,
            { buffer = ev.buf, desc = "Debug: test method" })
        vim.keymap.set("n", "<leader>tc", dap_python.test_class,
            { buffer = ev.buf, desc = "Debug: test class" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function(ev)
        vim.keymap.set("n", "<leader>tg", function() require("dap-go").debug_test() end,
            { buffer = ev.buf, desc = "Debug: go test" })
    end,
})
