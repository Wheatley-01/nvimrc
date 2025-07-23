-- lua/config/diagnostics.lua
local M = {}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

function M.setup()
	-- Sign column icons
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- Diagnostic appearance
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		severity_sort = true,
	})

	-- Notify LSP of buffer changes to trigger diagnostics
	vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufWritePost" }, {
		callback = function()
			-- Check if an LSP client is attached to the buffer
			local bufnr = vim.api.nvim_get_current_buf()

			-- Construct parameters manually
			local uri = vim.uri_from_bufnr(bufnr)
			local params = {
				textDocument = {
					uri = uri,
					version = vim.lsp.util.buf_versions[bufnr] or 0,
				},
				contentChanges = {
					{ text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") },
				},
			}

			-- Notify LSP server of changes
		end,
	})
end

return M
