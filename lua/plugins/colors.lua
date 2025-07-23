function ColorTheme(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			--colortheme("tokyonight")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			--ColorTheme("kanagawa")
		end,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			require("rose-pine").setup({
				variant = "moon",
			})

			--ColorTheme("rose-pine")
		end,
	},

	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "hard",
			})

			ColorTheme("everforest")
		end,
	},
}
