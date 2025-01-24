local M = {}

vim.g.mapleader = '\\'
require("config.lazy")
require("config.options")
require("config.map")
require("modules.usercmd")
require("modules.cterm")
require("modules.rpage")
require("modules.comment")

return M

