vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
})
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"basedpyright",
		"helm_ls",
		"yamlls",
		"bashls",
		"jsonls",
		"dockerls",
		"terraformls",
		"lua_ls",
		"ts_ls",
		"vue_ls",
		"svelte",
	},
	ensure_installation = true,
})
