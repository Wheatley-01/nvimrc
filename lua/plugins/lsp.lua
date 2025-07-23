return {
	{
		"lopi-py/luau-lsp.nvim",
		opts = {
			--require("luau-lsp").setup({
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

			server = {
				diagnostics = {
					globals = {
						"warn",
					},
				},
				settings = {
					["luau-lsp"] = {
						inlayHints = {
							parameterNames = "all",
						},
						hover = { multilineFunctionDefinitions = true },
						require = {
							mode = "relativeToFile",
							directoryAliases = type_aliases,
						},
						completion = {
							autocompleteEnd = true,
							addParantheses = true,
							imports = {
								enabled = true,
							},
						},
					},
				},
			},
			--	})
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = {
				exclude = { "luau_lsp" },
			},
		},

		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd" }, -- Ensure clangd is installed
				automatic_installation = true,
				handlers = {
					function(server_name)
						if server_name == "clangd" then
							-- Add this to your lsp.lua clangd configuration
							lspconfig.clangd.setup({
								capabilities = capabilities,
								cmd = {
									"clangd",
									"--background-index",
									"--clang-tidy",
									"--header-insertion=iwyu",
									"--completion-style=detailed",
									"--function-arg-placeholders",
									"--fallback-style=llvm",
									"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
								},
								init_options = {
									usePlaceholders = true,
									completeUnimported = true,
									clangdFileStatus = true,
									fallbackFlags = { "-std=c++17" },
								},
								filetypes = { "c", "cpp", "objc", "objcpp" },
								root_dir = lspconfig.util.root_pattern(
									"compile_commands.json",
									"compile_flags.txt",
									".clangd",
									".git"
								),
								single_file_support = true,
							})
						else
							require("lspconfig")[server_name].setup({})
						end

						if server_name == "luau_ls" then
							local lspconfig = require("lspconfig")
							lspconfig.lua_ls.setup({
								settings = {
									Lua = {
										diagnostics = {
											globals = {
												"vim",
												"it",
												"describe",
												"before_each",
												"after_each",
											},
										},
									},
								},
							})
						end
					end,
				},
			})
		end,
	},
}
