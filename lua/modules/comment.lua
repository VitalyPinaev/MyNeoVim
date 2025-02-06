local function comment_code()
	MODE = vim.fn.mode()

	if MODE == 'n' then


		SYMBOLT = ''
		FEXT = vim.fn.expand('%:e')

		if FEXT == "cpp" then SYMBOLT = '/'
		elseif FEXT == "lua" then SYMBOLT = '-'
		end

		local pos_cursor = vim.api.nvim_win_get_cursor(0)
		vim.fn.feedkeys('^')

		local line_under_cur = vim.fn.getline('.')
		local cur_col = vim.api.nvim_win_get_cursor(0)[2]
		local symbol_under_cur = string.sub(line_under_cur, cur_col, cur_col)

		if symbol_under_cur == SYMBOLT then
			vim.fn.feedkeys('3x', 'n')
			vim.api.nvim_win_set_cursor(0, {pos_cursor[1], pos_cursor[2]})
		else
			vim.fn.feedkeys('i' .. SYMBOLT .. SYMBOLT .. ' ', 'n')
			vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'n')
			vim.api.nvim_win_set_cursor(0, {pos_cursor[1], pos_cursor[2] + 3})
		end

	elseif MODE == 'v' or 'V' then
		local pos_cursor = vim.api.nvim_win_get_cursor(0)

		vim.cmd('<,\'>' .. 's/^\\s*/&' .. '-' .. '-' .. ' ')
		vim.cmd('noh')
	end


end

vim.keymap.set('n', '<C-/>', function () comment_code() end, { noremap = true, silent = true })
vim.keymap.set('v', '<C-i>', function () comment_code() end, { noremap = true, silent = true })
-- local lua = '-'
-- vim.keymap.set('v', '<C-i>', ':s/^\\s*/&' .. lua .. lua .. ' ' .. '<CR>' .. ':noh<CR>', { noremap = true, silent = true })
-- vim.keymap.set('v', '<C-i>', function ()
-- local cur = vim.fn.getpos("v")
-- print(cur)
-- vim.cmd(":\\<C-u>echo 'start=\" . string(getpos(\"v\")) . \" end=\" . string(getpos(\".\")) . \"\'\\<cr>gv\"")
-- end)
