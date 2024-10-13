-- Function for simple make map
local function map(mode, lsh, rsh, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set(mode, lsh, rsh, opts)
end

-- Save file
map("i", "<C-s>", "<Esc>:w<CR>")
map("n", "<C-s>", ":w<CR>")

-- Copy in system buffer
map('v', '<leader>c', '"+y')

-- Save and quit
map('i', '<C-q>', '<Esc>:wq<CR>')
map('n', '<C-q>', ':wq<CR>')

-- Copy line in insert mode
map('i', '<M-l>', '<Esc>V"+y')
map('n', '<M-l>', 'V"+y')

-- Move line up 
map('n', '<C-Up>', 'ddkkp==')
map('i', '<C-Up>', '<Esc>ddkkp==')

-- Move line down 
map('i', '<C-Down>', '<Esc>0v$yddp==')
map('n', '<C-Down>', '0v$yddp==')

-- BufferNext 
map('n', '<C-u>', ':BufferNext<CR>' )
map('i', '<C-u>', '<Esc> :BufferNext<CR>' )

-- BufferClose
map('n', '<C-m>', ':w<CR> :BufferClose<CR>')

require'nvim-tree'.setup {}
-- Open or close NvimTree 
map('n', '<C-n>', ':lua require("nvim-tree.api").tree.toggle()<CR>')
map('i', '<C-n>', '<Esc> :lua require("nvim-tree.api").tree.toggle()<CR>')

-- copy line and paste on next line
map('i', '<C-d>', '<esc>0v$hyo<esc>0p<esc>')
map('n', '<C-d>', '0v$hyo<esc>0p<esc>')

-- Drop a word 
map('i', '<M-w>', '<Esc>daw')
map('n', '<M-w>', 'daw')

-- Выделить всё внутри круглых скобок
map('i', '<M-(>', '<Esc>vib')
map('n', '<M-(>', 'vib')

-- Выделить всё внутри фигурных скобок
map('i', '<M-{>', '<Esc>viB')
map('n', '<M-{>', 'viB')

local builtin = require('telescope.builtin')
map('i', '<C-p>', "<ESC> :w<CR> :Telescope find_files<CR>")
map('n', '<C-p>', ":w<CR> :Telescope find_files<CR>")
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
