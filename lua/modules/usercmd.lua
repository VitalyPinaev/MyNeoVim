-------------------- 
-- HIGHLIGHT TEXT --
--------------------

vim.api.nvim_create_user_command("HighlightSelection", function()
	local color = ""
	while true do
		local input_color = vim.fn.input("Enter color: ")-- {{{
		if input_color == "Red" then color = "Red" break
		elseif input_color == "Green" then color = "Green" break
		elseif input_color == "Blue" then color = "Blue" break
		elseif input_color == "Cyan" then color = "Cyan" break
		elseif input_color == "Magenta" then color = "Magenta" break
		elseif input_color == "Yellow" then color = "Yellow" break
		elseif input_color == "Gray" then color = "Gray" break
		elseif input_color == "Black" then color = "Black" break
		elseif input_color == "Orange" then color = "Orange" break
		elseif input_color == "LightRed" then color = "LightRed" break
		elseif input_color == "LightGreen" then color = "LightGreen" break
		elseif input_color == "LightBlue" then color = "LightBlue" break
		elseif input_color == "LightCyan" then color = "LightCyan" break
		elseif input_color == "LightMagenta" then color = "LightMagenta" break
		elseif input_color == "LightYellow" then color = "LightYellow" break
		elseif input_color == "LightGray" then color = "LightGray" break
		elseif input_color == "White" then color = "White" break
		elseif input_color == "Purple" then color = "Purple" break
		elseif input_color == "DarkRed" then color = "DarkRed" break
		elseif input_color == "DarkGreen" then color = "DarkGreen" break
		elseif input_color == "DarkBlue" then color = "DarkBlue" break
		elseif input_color == "DarkCyan" then color = "DarkCyan" break
		elseif input_color == "DarkMagenta" then color = "DarkMagenta" break
		elseif input_color == "Brown" then color = "Brown" break
		elseif input_color == "DarkGray" then color = "DarkGray" break
		elseif input_color == "Violet" then color = "Violet" break
		elseif input_color == "SeaGreen" then color = "SeaGreen" break
		elseif input_color == "SlateBlue" then color = "SlateBlue" break
		elseif input_color == "DarkYellow" then color = "DarkYellow" break
		else goto continue
		end
	    ::continue::-- }}}
	end
	-- Create a highlight group for custom text color
	vim.api.nvim_set_hl(0, "CustomHighlight", { fg = color})
	-- Get the start and end positions of the visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Ensure valid positions
	if start_pos[2] == 0 or end_pos[2] == 0 then
		print("No valid selection found!")
		return
	end

	-- Loop through each line in the selection
	for line = start_pos[2], end_pos[2] do
		local col_start = (line == start_pos[2]) and start_pos[3] or 1
		local col_end = (line == end_pos[2]) and end_pos[3] or #vim.fn.getline(line)
		vim.fn.matchaddpos("CustomHighlight", { { line, col_start, col_end - col_start + 1 } })
	end
end, {})

-- Map the command to a key combination for visual mode
vim.keymap.set("v", "<M-f>", ":<C-U>HighlightSelection<CR>", { silent = true })


-------------------- 
-- UNHIGHLIGHT TEXT --
--------------------
vim.api.nvim_create_user_command('DeleteHighlightSelection', function ()
	-- Get group highlight
	local hl_group = vim.fn.synIDattr(syn_id, "name")

end, {bang = true})





















