return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"lopi-py/luau-lsp.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"luau_lsp",
				"rust_analyzer",
			},
			automatic_enable = {
				exclude = { "luau_lsp", "rust_analyzer" },
			},
		})

		require("luau-lsp").setup({
			platform = {
				type = "roblox",
			},
			types = {
				roblox_security_level = "PluginSecurity",
			},
			sourcemap = {
				enabled = true,
				autogenerate = true,
				sourcemap_file = "sourcemap.json",
				rojo_project_file = "default.project.json",
			},
			completion = {
				autocompleteEnd = true,
				addParantheses = true,
				imports = {
					enabled = true,
				},
			},
			require = {
				mode = "absolute",
			},
		})

		vim.diagnostic.config({
			update_in_insert = true,
		})
	end,
}
