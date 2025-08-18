vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<leader>ff", function()
	require("conform").format({
		timeout_ms = 50,
		lsp_format = "fallback",
	})
end)

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = { "*.lua", "*.luau" },
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })
