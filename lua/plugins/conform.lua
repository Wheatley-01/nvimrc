return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters_by_ft = {
			luau = { "stylua" },
			lua = { "stylua" },
			cpp = { "clang_format" },
		},

		format_on_save = {
			timeout_ms = 100,
			lsp_format = "fallback",
		},
	},
}
