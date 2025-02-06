------------- 
-- Options --
-------------

-- General opt
vim.opt.nu = true -- Enable line numbers
vim.opt.tabstop = 4 -- Set the width of a tab to 4 spaces
vim.opt.numberwidth = 1 -- Set the width of the line number column
vim.opt.shiftwidth = 4 -- Set the number of spaces for indentation
vim.opt.softtabstop = 4 -- Set the number of spaces per tab in insert mode
vim.opt.smartindent = true -- Enable intelligent indentation
-- vim.opt.scrolloff = 5 -- Keep 5 lines of context when scrolling
vim.opt.autoindent = true -- Preserve indentation from the previous line
vim.opt.ignorecase = true -- Disable case sensitivity
vim.opt.cursorline = true -- Highlight the line where the cursor is located
vim.opt.foldmethod = 'marker'
vim.opt.foldenable = true
vim.opt.sessionoptions = 'folds'


-- Fold opt
-- Set a custom function for foldtext
vim.opt.foldtext = "v:lua.CustomFoldText()"

-- Define the custom fold text function
function CustomFoldText()
  -- Get the start and end line indices of the fold
  local start_line = vim.v.foldstart
  local end_line = vim.v.foldend
  -- Format the text
  return string.format("📂 %d-%d", start_line, end_line)
end

---------
-- Cmd --
---------
vim.cmd.highlight("Comment guifg='Gray'") -- Change the color of comments to SeaGreen
vim.cmd.colorscheme("catppuccin-frappe") -- Apply the specified colorscheme
vim.cmd.highlight("Folded guibg=grey guifg=yellow")
