vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-mini/mini.nvim" }
})

require('catppuccin').setup({ flavour = 'mocha' })
require('mini.icons').setup()
require('mini.statusline').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.starter').setup()
require('mini.files').setup()
require('mini.pick').setup()
require('mini.cmdline').setup()





vim.lsp.enable({ 'lua_ls' })
-- 
--  { src = "https://github.com/folke/which-key.nvim" },
--  { src = "https://github.com/romgrk/barbar.nvim" },
--  { src = "https://github.com/numToStr/Comment.nvim" },
--  { src = "https://github.com/ibhagwan/fzf-lua" }
--  { src = "https://github.com/mfussenegger/nvim-lint" },
--  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
--  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
--  { src = "https://github.com/nvim-lualine/lualine.nvim" },
--  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
