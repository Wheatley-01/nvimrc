function ColorTheme(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			ColorTheme("tokyonight")
		end,
	},

	{
		{
			"rose-pine/neovim",
			lazy = false,
			priority = 1000,
			opts = {},

			config = function()
				require("rose-pine").setup({
					variant = "moon",
				})

				ColorTheme("rose-pine")
			end,
		},
	},
}
