vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-mini/mini.nvim" }
})

vim.lsp.enable({ 'lua_ls' })

require('catppuccin').setup({ flavour = 'mocha' })
require('mini.icons').setup()
require('mini.align').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.starter').setup()
require('mini.files').setup()
require('mini.pick').setup()
require('mini.cmdline').setup()
require('mini.extra').setup()
require('mini.tabline').setup()

-- -----------------------------------------------------------
-- Block for mini.snippets configuration in pack.lua      
-- -------------------------------------------------------
local gen_loader = require('mini.snippets').gen_loader                                                              
                                                                                                                    
-- Resolve your custom friendly-snippets path adaptively (handling Windows/Unix styles safely)                      
local friendly_snippets_path = vim.fn.expand('~/.local/share/nvim-jm/site/pack/core/opt/friendly-snippets/snippets')
                                                                                                                    
require('mini.snippets').setup({                                                                                    
  snippets = {                                                                                                      
    -- 1. Load custom global snippets (with safely expanded path)                                                   
    gen_loader.from_file(vim.fn.expand('~/.config/nvim-jm/snippets/global.json')),                                  
                                                                                                                    
    -- 2. Load the standard runtimepath snippets                                                                    
    gen_loader.from_lang(),                                                                                         
                                                                                                                    
    -- 3. Load the localized friendly-snippets matching the active buffer language                                  
    gen_loader.from_lang({ path = friendly_snippets_path }),                                                        
  },                                                                                                                
})                                                                                                                  
                                                                                                                    
-- CRITICAL: Expose loaded snippets to mini.completion / native menus via LSP                                       
require('mini.snippets').start_lsp_server()                                                                         
                                                                                                                    
-- Active completion layout                                                                                         
require('mini.completion').setup()                                                                                  
                                                                                                                    
-- -----------------------------------------------------------
-- Block for mini.clue configuration
-- ------------------------------------------------------------
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

-- **********************************************************************
-- Block for statusline
-- **********************************************************************
require('mini.statusline').setup({
  content = {
    active = function()
      -- 1. Grab the default statusline components
      local MiniStatusline = require('mini.statusline')
      local mode, mode_hl = MiniStatusline.section_mode({ truncate_width = 120 })
      local git           = MiniStatusline.section_git({ truncate_width = 75 })
      local diff          = MiniStatusline.section_diff({ truncate_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ truncate_width = 75 })
      local filename      = MiniStatusline.section_filename({ truncate_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ truncate_width = 120 })
      local location      = MiniStatusline.section_location({ truncate_width = 75 })
      local search        = MiniStatusline.section_searchcount({ truncate_width = 75 }) -- Fixed here

      -- 2. Build your custom wrap/spell indicators
      local extra_info = {}
      if vim.opt_local.spell:get() then
        table.insert(extra_info, "SPELL")
      end
      if vim.opt_local.wrap:get() then
        table.insert(extra_info, "WRAP")
      end
      
      -- Format the extra strings (e.g., "[SPELL|WRAP]")
      local extra_str = ""
      if #extra_info > 0 then
        extra_str = "[" .. table.concat(extra_info, "|") .. "] "
      end

      -- 3. Assemble and return the final statusline format string
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFilename', strings = { extra_str } }, -- Your custom indicators
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  },
})

