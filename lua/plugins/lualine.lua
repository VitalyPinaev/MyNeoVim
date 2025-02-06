return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },

	config = {
		options = {
			-- icons_enabled = true,
			theme = 'onedark',
			component_separators = {left = '', right = ''},
			section_separators = { left = '', right = ''},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			}
		},

		sections = {
			lualine_a = {'mode'},
			lualine_b = {function () return vim.fn.expand('%:r') end},
			lualine_c = {},
			lualine_x = {function () return [[UNIX]] end},
			lualine_y = {'filetype', 'progress'},
			lualine_z = {'location'}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
}
