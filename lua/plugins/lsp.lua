require("mason").setup()
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"eslint",
		"lua_ls",
		"tailwindcss-language-server",
		"ts_ls",
		"gopls",
		"sqls",
		"jsonls",
		"yamlls",
		"biome",
		"basedpyright",
		"ruff",
		"debugpy",
		"delve",
	},
	auto_update = false,
	run_on_start = true,
})

require("workspace-diagnostics").setup()

vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client then
				if client:supports_method("workspace/diagnostic", ev.buf) then
					vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
				else
					require("workspace-diagnostics").populate_workspace_diagnostics(client, ev.buf)
				end
			end

			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

			local opts = function(desc)
				return { buffer = ev.buf, silent = true, desc = desc }
			end
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts("Go to definition"))
			vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts("Hover documentation"))
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts("Go to implementation"))
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("Find references"))

			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
			-- vim.lsp.buf.format() applies *every* capable client in sequence, and
			-- lua_ls advertises formatting alongside stylua. Let stylua win.
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({
					filter = function(client) return client.name ~= "lua_ls" end,
				})
			end, opts("Format buffer"))

			-- <leader>d is taken by delete-without-yanking in config/keymaps.lua;
			-- a buffer-local map here would silently shadow it in every LSP buffer.
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end, opts("Show diagnostics float"))
		end,
	}
)
