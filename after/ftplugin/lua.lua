-- Map <localleader>r to run current Lua file 
vim.keymap.set('n', '<localleader>r', ':luafile %<CR>', { 
  buffer = true, 
  desc = "Execute current Lua file" 
})

vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true

vim.bo.commentstring = "-- %s"

