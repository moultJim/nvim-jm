-- Hard wrapping - at 80 characters
vim.opt_local.formatoptions:append({ "t" })
vim.opt_local.textwidth = 80

-- Automatically treat list items nicely when hitting Enter
vim.opt_local.formatoptions:append("r")

-- ****************************************************************************
-- Open glow with buffer in native vertical split window on right
-- ****************************************************************************
vim.keymap.set('n', '<localleader>p', function()
    local current_file = vim.api.nvim_buf_get_name(0)
    -- Open a vertical split, move cursor right, and start a terminal with glow
    vim.cmd('vsplit | wincmd l | terminal glow "' .. current_file .. '"')
    -- Force terminal into "Insert mode" so you can scroll or quit with 'q'
    vim.cmd('startinsert')
end, { buffer = true, desc = "Preview Markdown with glow" })
-- ****************************************************************************
-- Alt keymap to pipe current buffer to glow floating terminal window
-- ****************************************************************************
vim.keymap.set(
    'n', '<localleader>mp', ':TermExec cmd="glow %"<CR>', 
    { buffer = true, desc = "Preview with Glow" }
)

-- ****************************************************************************
-- Keymap to align a markdown table (using mini.align)
-- ****************************************************************************
-- Assumes table surrounded by empty lines; cursor inside table; Normal Mode
vim.keymap.set(
  'n',
  'at',
  function()
    -- Feed keys for: ga (align) + ip (inner paragraph) + s (split) + | (pipe)
    -- + (confirm)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
      'gaips|',
      true,
      false,
      true
      ),
    'm',
    true
    )
  end,
  { desc = 'Align Markdown table' }
)

-- ****************************************************************************
-- Alternative table alignment using column command
-- ****************************************************************************
vim.keymap.set(
  'v',
  '<localleader>mt',
  ":!column -t -s '|' -o '|'<CR>",
  { buffer = true, silent = true, desc = "Format table via system column" }
)

-- ****************************************************************************
-- Insert 3-column table skeleton in insert mode
-- ****************************************************************************
vim.keymap.set(
    'i',
    'msk3',
    [[| Head1 | Head2 | Head3 |<CR>|:--- |:--- |:--- |<CR>| | | |]], 
    { buffer = true, desc = "Insert markdown table-3 skeleton" }
)

-- ****************************************************************************
-- Insert 2-column table skeleton in insert mode
-- ****************************************************************************
vim.keymap.set(
    'i',
    'msk2',
    [[| Head1 | Head2 | <CR>|:--- |:--- |<CR>| | |]], 
    { buffer = true, desc = "Insert markdown table-2 skeleton" }
)

-- ********************************************************
-- Function & keymap: jump to next Markdown table cell
-- ********************************************************
local function jump_to_next_cell()
    -- Refined pattern: Finds a pipe, followed by optional spaces,
    -- and targets the cell gap
    local pattern = [[|\s*]]
    local found = vim.fn.search(pattern, 'W')
    if found > 0 then
        -- Move cursor past the matched pipe and its immediately following space
        local col = vim.fn.col('.')
        local match_len = vim.fn.matchstr(
          vim.fn.getline('.'),
          pattern,
          col - 1):len()
        vim.fn.cursor(vim.fn.line('.'), col + match_len)
        vim.cmd('startinsert')
    end
end

vim.keymap.set(
  'i',
  '<C-j>',
  jump_to_next_cell,
  { buffer = true, silent = true, desc = "Jump to next table cell" }
)

-- ********************************************************
-- Add new row to table, duplicating current cell structure
-- ********************************************************
local function add_blank_row_below()
    local current_line = vim.fn.getline('.')
    -- Count how many columns/pipes are in the current line
    local _, pipe_count = string.gsub(current_line, "|", "")
    -- If not inside a table row, drop down a standard line safely
    if pipe_count < 2 then
        vim.api.nvim_put({""}, "l", true, true)
        vim.cmd('startinsert!')
        return
    end
    -- Build blank row matching structural layout (e.g., "|  |  |")
    local new_row = "|" .. string.rep("  |", pipe_count - 1)
    local row_num = vim.fn.line('.')
    vim.fn.append(row_num, new_row)
    -- Safely target the first cell interior (Column 3)
    vim.fn.cursor(row_num + 1, 3)
    vim.cmd('startinsert')
end
vim.keymap.set(
  'i',
  '<C-o>',
  add_blank_row_below,
  { buffer = true, silent = true, desc = "Add new blank table row below" })


