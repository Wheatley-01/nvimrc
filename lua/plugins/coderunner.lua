return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				cpp = {
					"cd $dir &&",
					"g++ -o $fileNameWithoutExt $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc -o $fileNameWithoutExt $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
			},
		})

		-- Key mapping to run code
		vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run code" })
		vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { desc = "Run file" })
		vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { desc = "Close runner" })
	end,
}
