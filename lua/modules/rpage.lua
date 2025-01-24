-- This code allows you to scroll through the Neovim buffer like pages.
-- When moving to the next or previous page, the top two lines of the current page 
-- are preserved at the top of the screen in the new page.

---------------------- Move to the next page --------------------

local function move_page (where_move)
	-- A flag to prevent redundant initialization during multiple calls
	local checking_execution_function = false

	-- If the flag is false, initialize variables only once
	if checking_execution_function == false then
		checking_execution_function = true

		-- Calculate the number of visible lines in the current window
		AVERAGE_VISIBLE = vim.fn.line('w$') - vim.fn.line('w0')

		-- Calculate the remainder to determine if the number of lines is odd or even
		REMAINDER = AVERAGE_VISIBLE % 2
	end

	-- Set the cursor to the first visible line of the window
	vim.api.nvim_win_set_cursor(0, {vim.fn.line('w0'), 1})

	-- Perform scrolling logic if initialization is complete
	if checking_execution_function == true then

		-- Scroll down by the total visible lines
		if where_move == 'j' then
			vim.fn.feedkeys(AVERAGE_VISIBLE .. where_move)
		end

		-- Handle even or odd visible lines to adjust scrolling behavior
		if REMAINDER == 0 then
			-- For even lines, scroll half of the page twice
			vim.fn.feedkeys(AVERAGE_VISIBLE / 2 .. where_move .. AVERAGE_VISIBLE / 2 .. where_move)
			-- vim.fn.feedkeys(AVERAGE_VISIBLE / 2 .. where_move)
		elseif REMAINDER ~= 0 then
			-- For odd lines, adjust by subtracting 1 and scroll half the page twice
			vim.fn.feedkeys((AVERAGE_VISIBLE - 1) / 2 .. where_move .. (AVERAGE_VISIBLE - 1) / 2 .. where_move)
			-- vim.fn.feedkeys((AVERAGE_VISIBLE - 1) / 2 .. where_move)
		end
	end

	-- Reset the cursor to the first visible line to maintain consistency
	vim.api.nvim_win_set_cursor(0, {vim.fn.line('w0'), 1})

end
-- Set a key mapping for scrolling down in normal or terminal mode
vim.keymap.set('n' or 't', '<Down>', function () move_page('j') end , {noremap = true, silent = true})
vim.keymap.set('n' or 't', '<Up>', function () move_page('k') end , {noremap = true, silent = true})


