vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>pq", "ggVGd")
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+Y')

-- In your init.lua or keymaps file
vim.keymap.set("n", "<leader>n", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>sv", ":vnew<CR>", { desc = "New vertical split" })
vim.keymap.set("n", "<leader>sh", ":new<CR>", { desc = "New horizontal split" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bb", ":buffers<CR>", { desc = "List buffers" })

-- Add this to your init.lua or keymaps file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.keymap.set("n", "<F5>", function()
			vim.cmd("w") -- save file
			vim.cmd("below split | resize 10 | terminal")
			local filename = vim.fn.expand("%:t:r") -- filename without extension
			local compile_cmd = string.format("g++ -o %s %s", filename, vim.fn.expand("%:t"))

			-- Send commands to terminal
			vim.api.nvim_chan_send(vim.b.terminal_job_id, compile_cmd .. "\n")
			vim.api.nvim_chan_send(vim.b.terminal_job_id, string.format("./%s\n", filename))
		end, { desc = "Compile and run C++ (interactive)" })
	end,
})
