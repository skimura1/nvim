-- Registered before vim.pack.add so first-install PackChanged events are seen.
require("plugins.hooks")

vim.pack.add({
    "https://github.com/metalelf0/black-metal-theme-neovim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/artemave/workspace-diagnostics.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/mfussenegger/nvim-dap-python",
    "https://github.com/leoluz/nvim-dap-go",
    "https://github.com/fredrikaverpil/godoc.nvim",
    "https://github.com/olexsmir/gopher.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/refractalize/oil-git-status.nvim",
})

require("plugins.colorscheme")
require("plugins.markdown")
require("plugins.oil")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.python")
require("plugins.dap")
require("plugins.go")
