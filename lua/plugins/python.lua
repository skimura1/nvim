--- python: basedpyright for types, ruff for lint + format ---

-- Resolve the interpreter a project's language server should use. uv, poetry
-- and plain `venv` all drop a `.venv` in the project root; an activated shell
-- ($VIRTUAL_ENV) wins over that, and system python is the last resort.
local function python_path(root)
    if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
    end
    for _, name in ipairs({ ".venv", "venv" }) do
        local candidate = root .. "/" .. name .. "/bin/python"
        if vim.fn.executable(candidate) == 1 then
            return candidate
        end
    end
    return vim.fn.exepath("python3")
end

-- No `on_attach` here on purpose: lspconfig's own one defines
-- :LspPyrightOrganizeImports and :LspPyrightSetPythonPath, and ours would
-- replace it rather than run alongside.
vim.lsp.config("basedpyright", {
    -- `client.settings` -- not the config table -- is what Neovim serves back
    -- to the server's workspace/configuration requests, so set it there.
    on_init = function(client)
        client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
            python = { pythonPath = python_path(client.root_dir or vim.fn.getcwd()) },
        })
    end,
    settings = {
        basedpyright = {
            -- ruff owns import sorting and lint diagnostics
            disableOrganizeImports = true,
            analysis = {
                -- basedpyright's own default ("recommended") is very loud on
                -- untyped code; "standard" matches stock pyright.
                typeCheckingMode = "standard",
                -- ruff reports these too; without this they show up twice
                diagnosticSeverityOverrides = {
                    reportUnusedImport = "none",
                    reportUnusedVariable = "none",
                },
            },
        },
    },
})

vim.lsp.config("ruff", {
    on_attach = function(client)
        -- basedpyright gives richer hovers; let it own them so <leader><space>
        -- doesn't get ruff's thinner version.
        client.server_capabilities.hoverProvider = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.colorcolumn = "88" -- ruff's default line length
    end,
})
