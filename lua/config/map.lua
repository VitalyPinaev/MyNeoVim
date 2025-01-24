------------------------------
-- Function for make HotKey -- 
------------------------------
local function map(mode, lsh, rsh, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set(mode, lsh, rsh, opts)
end


-------------
-- HotKeys --
-------------

-- Save file
map('i', '<C-s>', '<Esc>:w<CR>')
map('n', '<C-s>', ':w<CR>')

-- Copy in system buffer
map('v', '<C-c>', '"+y')

-- Save and quit
map('i', '<C-q>', '<Esc>:wq<CR>')
map('n', '<C-q>', ':wq<CR>')

-- Move line up 
map('n' , '<C-Up>', '<Esc>ddkkp==')
map('n', '<C-Up>', 'ddkkp==')

-- Move line down 
map('i', '<C-Down>', '<Esc>0v$yddp==')
map('n' , '<C-Down>', '<Esc>0v$yddp==')

-- BufferNext 
map('i', '<C-u>', '<Esc>:BufferNext<CR>' )
map('n', '<C-u>', ':BufferNext<CR>' )

-- BufferClose
map('n', '<C-m>', ':w<CR> :BufferClose<CR>')

-- Open or close NvimTree 
map('i', '<C-n>', '<Esc> :lua require("nvim-tree.api").tree.toggle()<CR>')
map('n', '<C-n>', ':lua require("nvim-tree.api").tree.toggle()<CR>')

-- copy line and paste on next line
map('i', '<C-d>', '<esc>yyp')
map('n', '<C-d>', 'yyp')
