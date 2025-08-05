return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	opts = {},

	config = function()
		-- require("cord").setup({
		-- 	assets = {
		-- 		[".luau"] = {
		-- 			icon = "https://raw.githubusercontent.com/Wheatley-01/icons/c5f65a1a3b2cbeef57ff5db496e58d43edf6a5b2/luau.svg", -- asset name or url
		-- 			tooltip = "Luau", -- hover text
		-- 		},
		-- 	},
		-- })
	end,
}
