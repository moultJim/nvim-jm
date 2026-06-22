vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" }
})

require('catppuccin').setup({ flavour = 'mocha' })

-- 
--  { src = "https://github.com/folke/which-key.nvim" },
--  { src = "https://github.com/romgrk/barbar.nvim" },
--  
--  { src = "https://github.com/numToStr/Comment.nvim" },
--  { src = "https://github.com/ibhagwan/fzf-lua" }
