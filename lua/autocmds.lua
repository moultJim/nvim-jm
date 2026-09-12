-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})
-- Create an autocommand group for help window management
local help_group = vim.api.nvim_create_augroup(
  "HelpWindowManagement",
  { clear = true })

-- Open file with cursor where exited
-- BufReadPost event fires after nvim finishes reading file into buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
-- nvim_buf_get_mark(0, '"') fetches position of last exit mark    
    local mark = vim.api.nvim_buf_get_mark(0, '"')
-- checking saved line # is valid and still exists within current line count
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Don't autocomment next line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
-- "r" is auto after <cr>; "o" after o or O ins; "c" is for hard-wraps
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = help_group,
  pattern = "help",
  callback = function()
    -- Record the ID of the window you came from
    local original_win = vim.fn.win_getid(vim.fn.winnr('#'))
    
    -- Map 'q' inside this specific help buffer to close it and jump back
    vim.keymap.set("n", "q", function()
      -- Close the help window
      vim.cmd("q")
      -- If the original window is still valid, return focus to it
      if vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
      end
    end, { buffer = true, silent = true,
      desc = "Close help and return to previous window" }
    )
  end,
})

