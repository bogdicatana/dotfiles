-- plugins/lsp.lua
return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "rust_analyzer", "lua_ls", "pyright", "ts_ls", "tinymist" }, -- your LSPs
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
		vim.lsp.enable(
			'clangd', 'cssls', 'html', 'lua_ls', 'ts_ls', 'pyright', 'rust_analyzer', 'tinymist',
			'sqlls'
		),
   --      config = function()
   --          local lspconfig = require("lspconfig")
			-- --local lspconfig = vim.lsp.config()
   --          lspconfig.lua_ls.setup({})
   --          lspconfig.pyright.setup({})
   --          lspconfig.ts_ls.setup({})
   --          lspconfig.clangd.setup({})
   --          lspconfig.rust_analyzer.setup({})
   --          lspconfig.tinymist.setup({
   --              settings = {
   --                  formatterMode = "typstyle",
   --                  exportPdf = "onType",
   --                  semanticTokens = "disable"
   --              }
   --          })
   --          -- Add more servers as needed
   --      end,
    },
}
