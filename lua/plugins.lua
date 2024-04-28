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
            "tpope/vim-rhubarb",}
        }
    }
