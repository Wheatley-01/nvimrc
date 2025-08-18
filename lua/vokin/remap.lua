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

vim.keymap.set("n", "zR", function()
	require("ufo").openAllFolds()
end)
vim.keymap.set("n", "zM", function()
	require("ufo").closeAllFolds()
end)

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>")

vim.keymap.set("n", "zK", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "peek fold" })

-- In your init.lua or keymaps file
vim.keymap.set("n", "<leader>n", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>sv", ":vnew<CR>", { desc = "New vertical split" })
vim.keymap.set("n", "<leader>sh", ":new<CR>", { desc = "New horizontal split" })

vim.keymap.set("n", "<CR>", "m`o<Esc>``")
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

-- Navigate to buffers by their position in the bufferline
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		require("bufferline").go_to(i, true)
	end, { desc = "Go to buffer " .. i })
end
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>w", function()
	vim.diagnostic.open_float(nil, {
		border = "rounded",
		style = "minimal",

		focusable = false,
	})
end, { silent = true })
