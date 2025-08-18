-- Term Toggle Function
local term_buf = nil
local term_win = nil

-- Ensure term_buf and term_win are global or accessible
term_buf = nil
term_win = nil

function TermToggle(height)
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.cmd("hide")
	else
		vim.cmd("botright new")
		local new_buf = vim.api.nvim_get_current_buf()
		vim.cmd("resize " .. height)
		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			vim.cmd("buffer " .. term_buf) -- go to terminal buffer
			vim.cmd("bd " .. new_buf) -- cleanup new buffer
		else
			vim.cmd("terminal")
			term_buf = vim.api.nvim_get_current_buf()
			vim.wo.number = false
			vim.wo.relativenumber = false
			vim.wo.signcolumn = "no"
		end
		vim.cmd("startinsert!")
		term_win = vim.api.nvim_get_current_win()
	end
end

-- function RunCpp()
-- 	-- Save the current file
-- 	vim.cmd("write")
-- 	-- Get the current file name
-- 	local file = vim.fn.expand("%:p")
-- 	-- Get the file name without extension for the output binary
-- 	local output = vim.fn.expand("%:p:r")
-- 	-- Compile the C++ file
-- 	local compile_cmd = "g++ -o " .. output .. " " .. file
-- 	-- Run the compiled program using the full path
-- 	local run_cmd = output -- Use the full path directly
-- 	-- Check if on Windows (use .exe extension)
-- 	if vim.fn.has("win32") == 1 then
-- 		run_cmd = output .. ".exe"
-- 	end
-- 	-- Open terminal if not already open
-- 	TermToggle(10)
-- 	-- Ensure terminal buffer is valid before sending commands
-- 	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
-- 		-- Clear terminal and send compile + run commands
-- 		vim.api.nvim_chan_send(
-- 			vim.api.nvim_buf_get_option(term_buf, "channel"),
-- 			"clear && " .. compile_cmd .. " && " .. run_cmd .. "\r"
-- 		)
-- 	else
-- 		print("Error: Terminal buffer is not valid")
-- 	end
-- end

function RunCpp()
	-- Save the current file
	vim.cmd("write")
	-- Get the current file name
	local file = vim.fn.expand("%:p")
	-- Get the file name without extension for the output binary
	local output = vim.fn.expand("%:p:r")
	-- Compile the C++ file
	local compile_cmd = "g++ -o " .. output .. " " .. file
	-- Run the compiled program using the full path
	local run_cmd = output -- Use the full path directly
	local delete_cmd = "rm " .. output -- Default delete command

	-- Check if on Windows (use .exe extension)
	if vim.fn.has("win32") == 1 then
		run_cmd = output .. ".exe"
		delete_cmd = "del " .. output .. ".exe" -- Windows delete command
	end

	-- Open terminal if not already open
	TermToggle(10)
	-- Ensure terminal buffer is valid before sending commands
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		-- Clear terminal and send compile + run + delete commands
		vim.api.nvim_chan_send(
			vim.api.nvim_buf_get_option(term_buf, "channel"),
			"clear && " .. compile_cmd .. " && " .. run_cmd .. " && " .. delete_cmd .. "\r"
		)
	else
		print("Error: Terminal buffer is not valid")
	end
end

-- Keymaps
vim.keymap.set("n", "<leader>pt", ":lua TermToggle(10)<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<leader>pt", "<C-\\><C-n>:lua TermToggle(10)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pc", ":lua RunCpp()<CR>", { noremap = true, silent = true })
