local M = {}
	vim.api.nvim_create_user_command('KotlinTerm', function ()
	-- Get full path to source file
	local path_compiling = vim.fn.expand('%:p')
	local name_file_no_extend = vim.fn.expand('%:p:r')

	-- Setup terminal
	vim.api.nvim_command('belowright new')
    vim.api.nvim_command('resize -10')
    vim.api.nvim_command('terminal')
	vim.api.nvim_command('setlocal nonumber norelativenumber ')
    vim.api.nvim_feedkeys('A', 'n', false)
    vim.api.nvim_buf_set_name(0, 'Terminal')

	-- Compiling the source
	vim.fn.system('kotlinc ' .. path_compiling .. ' -include-runtime ' .. '-d ' .. name_file_no_extend .. '.jar' .. '\n')
	-- Save return value after compile
	local compile_status = vim.v.shell_error

	-- 
	if compile_status == 0 then
		-- Clear the terminal
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
		-- Start programm
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'java -jar ' .. name_file_no_extend .. '.jar' .. '\n')

	else
		-- Clear terminal
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
		-- Show conclusion of compiling
		vim.api.nvim_chan_send(vim.b.terminal_job_id ,'kotlinc ' .. path_compiling .. ' -include-runtime ' .. '-d ' .. name_file_no_extend .. '.jar' .. '\n')
	end
end, {})

-------------------------------
-- HotKey for start terminal --
-------------------------------
vim.keymap.set('i', '<M-j>', '<ESC>:w<CR>:KotlinTerm<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<M-j>', ':w<CR>:KotlinTerm<CR>', {silent = true, noremap = true})


-------------------------------
-- HotKey for close terminal -- 
-------------------------------
vim.keymap.set('t', '<M-k>', function ()
	vim.api.nvim_chan_send(vim.b.terminal_job_id, 'exit\n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
	vim.api.nvim_command('bd!')
end, {silent = true, noremap = true})

return M
