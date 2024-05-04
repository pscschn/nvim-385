return {
    {
        'folke/which-key.nvim',
        lazy = true,
    },

    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },
    {
        'tamton-aquib/staline.nvim'
    },
    {
        'tpope/vim-fugitive'
    },
    {
        'tpope/vim-rhubarb'
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        cmd = { "AdvancedGitSearch" },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- to show diff splits and open commits in browser
            "tpope/vim-fugitive",
            -- to open commits in browser with fugitive
            "tpope/vim-rhubarb",
        }
    },
    {
        'catppuccin/nvim', name = 'catppuccin', priority = 1000
    },
    {
        'nvim-tree/nvim-web-devicons'
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        'norcalli/nvim-colorizer.lua'
    },
    {

        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {}
    }
}
