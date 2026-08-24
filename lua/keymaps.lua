vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.keymap.set(modes, lhs, rhs, opts)
-- modes a single string (e.g., "n" for normal), or table (e.g., {"n", "v"})v
-- "x" is visual only; "v" visual and select
-- "i" insert; "c" command; "" all modes
-- lhs left hand side: keys pressed
-- rhs rght hand side: action: cmds  or keys

-- ***CONROL***
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode with jj' })
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>', { desc = 'Open netrw file explorer' })
vim.keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle line wrapping" })
-- Move by visual lines, not logical lines (great for wrapped markdown text)
vim.keymap.set("n", "j", "gj", { silent = true, desc = "Move down visual line" })
vim.keymap.set("n", "k", "gk", { silent = true, desc = "Move up visual line" })
-- Toggle for conceallevel: 0 no conceal; 2 conceal
vim.keymap.set('n', '<leader>tc', function()   
  if vim.opt_local.conceallevel:get() == 0 then
    vim.opt_local.conceallevel = 2             
    print("Conceal level set to 2")            
  else                                         
    vim.opt_local.conceallevel = 0             
    print("Conceal level set to 0")            
  end                                          
end, { desc = "Toggle [C]onceal level (0/2)" })
-- Toggle for word wrap; when soft wrap enabled, wrap at word break
vim.keymap.set('n', '<leader>tw', function()
  -- Toggle the wrap option state
  local wrapping = not vim.opt_local.wrap:get()
  
  vim.opt_local.wrap = wrapping
  vim.opt_local.linebreak = wrapping -- Turns linebreak on/off matching wrap
  
  if wrapping then
    print("Soft wrap enabled (with word boundary)")
  else
    print("Soft wrap disabled")
  end
end, { desc = "Toggle soft [W]rap" })
-- Toggle for spell check
vim.keymap.set('n', '<leader>ts', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  if vim.opt_local.spell:get() then
    print("Spell check enabled")
  else
    print("Spell check disabled")
  end
end, { desc = "Toggle [S]pell check" })



-- ***GENERAL EDIT - NORMAL MODE***
-- Delete without yanking: Handles counts naturally (e.g., <leader>2d deletes 2 lines)
vim.keymap.set('n', '<leader>d', function()
  return '"_' .. vim.v.count1 .. 'd'
end, { expr = true, desc = "Delete line(s) without yanking" })
-- Delete a character without yanking
vim.keymap.set('n', 'x', '"_x', { desc = "Delete character without yanking" })
-- Change text without yanking (handles counts like <leader>2c)
vim.keymap.set('n', '<leader>c', function()
  return '"_' .. vim.v.count1 .. 'c'
end, { expr = true, desc = "Change without yanking" })
-- Change current line without yanking (handles counts like <leader>2cc)
vim.keymap.set('n', '<leader>cc', function()
  return '"_' .. vim.v.count1 .. 'S'
end, { expr = true, desc = "Change line without yanking" })
-- (Note: For <leader>cc, using S behind the scenes is a clean Vim trick
-- to clear line and enter insert mode while respecting counts perfectly).
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "<leader>mj", "m .+1<CR>==", { desc = "Move line down 1" })
vim.keymap.set("n", "<leader>mk", "m .-2<CR>==", { desc = "Move line up 1" })
-- Re-align paragraph under cursor to match margin limits if a md file:
--    gq triggers internal formatter; ap = "around paragraph".
vim.keymap.set("n", "Q", "gqap", { desc = "Format current paragraph" })

-- ***EDIT - VISUAL MODE***
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
vim.keymap.set('v', '<leader>d', '"_d', { desc = "Delete selection without yanking" })
-- Delete visual selection character-wise without yanking
vim.keymap.set('v', 'x', '"_x', { desc = "Delete selection without yanking" })

-- Change visual selection without yanking
vim.keymap.set('v', '<leader>c', '"_c', { desc = "Change selection without yanking" })



-- ***NAVIGATION***
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll dwn 1/2 pg, & center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up 1/2 pg, & center" })
vim.keymap.set("n", "H", "^", { desc = "go to non-blank start of line" })
vim.keymap.set("n", "L", "$", { desc = "go to end of line" })

-- ***WINDOWS AND SPLITS***
--vim.keymap.set("n", "<leader>sv", "<C-w> v", { desc = "split window vertically" })
--vim.keymap.set("n", "<leader>sh", ":sp", { desc = "split window horizontally" })
--vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move to window on left" })
--vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "move to window below" })
--vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "move to window above" })
--vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "move to window on right" })


--***SEARCH***
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- ***FILES***
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Quick save buffer" })
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- ***MARKDOWN-RELATED***
-- Jump to next/previous markdown header
vim.keymap.set("n", "]]", [[:/^\s*#\+ /<CR>:nohlsearch<CR>]], { silent = true, desc = "Next header" })
vim.keymap.set("n", "[[", [[:?^\s*#\+ ?<CR>:nohlsearch<CR>]], { silent = true, desc = "Previous header" })
-- Turn current line into a bullet point list item
vim.keymap.set("n", "<leader>bl", "I- <Esc>", { desc = "Make list item" })
-- Down or up navigation by visual lines if wrapped text
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

