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
        'catppuccin/nvim', name = 'catppuccin',  
        opts = {
            custom_highlights = function(colors)
                return {
                    TelescopeMatching = { fg = colors.flamingo },
                    TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

                    TelescopePromptPrefix = { bg = colors.surface0 },
                    TelescopePromptNormal = { bg = colors.surface0 },
                    TelescopeResultsNormal = { bg = colors.mantle },
                    TelescopePreviewNormal = { bg = colors.mantle },
                    TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
                    TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
                    TelescopeResultsTitle = { fg = colors.mantle },
                    TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
                }
           end,
        }, 
    },
     {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
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
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}
    },
--    {
--        "windwp/nvim-autopairs"
--    },
}
