return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- LSP
				"lua-language-server",
				"rust-analyzer",
				"pyright",
				"taplo",
				"json-lsp",
				"jdtls",
				"lemminx",
				"clangd",
				-- Formatter
				"isort",
				"black",
				-- DAP
				"debugpy",
				"codelldb",
				"java-debug-adapter",
				"java-test",
			},
		},
	},
}
