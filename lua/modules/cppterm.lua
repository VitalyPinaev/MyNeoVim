--------------------------------------
-- Terminal for fast compiling of C --
--------------------------------------

vim.api.nvim_create_user_command('CTerm', function ()
	-- Get full path to source file
	local path_compiling = vim.fn.expand('%:p')

	-- Setup terminal
	vim.cmd('belowright new')
    vim.cmd('resize -10')
    vim.cmd('terminal')
	vim.cmd('setlocal nonumber norelativenumber ')
    vim.api.nvim_feedkeys('A', 'n', false)
    vim.api.nvim_buf_set_name(0, 'Terminal')

	-- Compiling the source
	vim.fn.system('g++ ' .. path_compiling)
	-- Save return value after compile
	local compile_status = vim.v.shell_error

	-- 
	if compile_status == 0 then
		-- Clear the terminal
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
		-- Start programm
		vim.api.nvim_chan_send(vim.b.terminal_job_id, './a.out\n')

	else
		-- Clear terminal
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'clear\n')
		-- Show conclusion of compiling
		vim.api.nvim_chan_send(vim.b.terminal_job_id, 'g++ ' .. path_compiling .. '\n')
	end
end, {})

-------------------------------
-- HotKey for start terminal --
-------------------------------
vim.keymap.set('i', '<M-j>', '<ESC>:w<CR>:CTerm<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<M-j>', ':w<CR>:CTerm<CR>', {silent = true, noremap = true})


-------------------------------
-- HotKey for close terminal -- 
-------------------------------
vim.keymap.set('t', '<M-k>', function ()
	vim.api.nvim_chan_send(vim.b.terminal_job_id, 'exit\n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
	vim.cmd('bd!')
end, {silent = true, noremap = true})
