------------- 
-- Options --
-------------
vim.opt.nu = true -- Enable line numbers
vim.opt.tabstop = 4 -- Set the width of a tab to 4 spaces
vim.o.syntax = true -- Enable syntax highlighting
vim.opt.numberwidth = 1 -- Set the width of the line number column
vim.opt.shiftwidth = 4 -- Set the number of spaces for indentation
vim.opt.softtabstop = 4 -- Set the number of spaces per tab in insert mode
vim.opt.smartindent = true -- Enable intelligent indentation
vim.opt.scrolloff = 5 -- Keep 5 lines of context when scrolling
vim.opt.autoindent = true -- Preserve indentation from the previous line
vim.opt.ignorecase = true -- Disable case sensitivity
vim.opt.cursorline = true -- Highlight the line where the cursor is located

---------
-- Cmd --
---------
vim.cmd.highlight("Comment guifg='Gray'") -- Change the color of comments to SeaGreen
vim.cmd("setlocal showtabline=0") -- Statusline none
vim.cmd.colorscheme("catppuccin-frappe") -- Apply the specified colorscheme
