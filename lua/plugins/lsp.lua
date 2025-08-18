return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities(),
				{
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
				{
					textDocument = {
						inlayHint = {
							dynamicRegistration = true,
							resolveProvider = true,
						},
					},
				}
			)
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

			vim.lsp.config("luau-lsp", {
				settings = {
					["luau-lsp"] = {
						autocompleteEnd = true,
						completion = {

							imports = {
								enabled = true, -- enable auto imports
							},
						},
					},
				},
			})
			vim.lsp.config("*", {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})

			--vim.lsp.inlay_hint.enable(true)
			vim.diagnostic.config({
				update_in_insert = true,
			})
		end,
	},

	{
		{
			"lopi-py/luau-lsp.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},

			config = function()
				require("luau-lsp").setup({
					platform = {
						type = "roblox",
					},
					types = {
						roblox_security_level = "PluginSecurity",
					},

					sourcemap = {
						enabled = true,
						autogenerate = true, -- automatic generation when the server is initialized
						rojo_project_file = "default.project.json",
						sourcemap_file = "sourcemap.json",
					},
					plugin = {
						enabled = true,
						port = 3667,
					},
				})
			end,
		},
	},
}
