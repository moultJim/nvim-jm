-- enable faster startup by caching compiled lua modules
vim.loader.enable()

require("options")
require("keymaps")
require("autocmds")
require("pack")
