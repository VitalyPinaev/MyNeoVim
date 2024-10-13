return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
	-- General settings
  auto_reload_on_write = true,   -- Automatically reload the tree when files are changed
  disable_netrw = true,          -- Disable netrw (builtin file explorer) to use nvim-tree
  hijack_cursor = false,         -- Do not hijack the cursor to stay in the tree
  hijack_netrw = true,           -- Hijack netrw to ensure nvim-tree is used
  update_cwd = true,             -- Update current working directory when opening files

  -- View settings
  view = {
      width = 30,                -- Set the width of the tree window
      side = 'left'              -- Position of the tree window ('left' or 'right')
  },

  -- Filters
  filters = {
      dotfiles = false,           -- Show dotfiles 
      custom = {                   -- Custom filters
          ".git",                  -- Ignore '.git' directories
          "node_modules",          -- Ignore 'node_modules' directories
      }
  },

  -- Git integration
  git = {
      enable = true,              -- Enable Git integration
      ignore = true,              -- Ignore Git ignore rules
      timeout = 400,              -- Git operation timeout
  },

  -- Actions
  actions = {
      open_file = {
          quit_on_open = true,    -- Close tree after opening a file
      }
  },
}

require'nvim-tree'.setup {
  renderer = {
    icons = {
      glyphs = {
        default = "", -- Icon for regular files
        symlink = "", -- Icon for symbolic links
        git = {
          unstaged = "✗", -- Icon for unstaged Git changes
          staged = "✓", -- Icon for staged Git changes
          unmerged = "", -- Icon for Git merge conflicts
          renamed = "➜", -- Icon for renamed Git files
          deleted = "", -- Icon for deleted Git files
          ignored = "◌", -- Icon for ignored Git files
        },
        folder = {
          default = "", -- Icon for regular folders 
          open = "", -- Icon for open folders 
          empty = "", -- Icon for empty folders 
          empty_open = "", -- Icon for open empty folders 
          symlink = "" -- Icon for symbolic links to folders 
        }
      }
    }
  }
    }
  end,
}
