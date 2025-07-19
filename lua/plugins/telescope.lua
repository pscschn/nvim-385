return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-symbols.nvim"
    },
    opts = {
        defaults = {
            preview = {
                treesitter = false
            }
        }
    },
    keys = {
        {"<leader>ff", mode = "n", "<cmd>Telescope find_files<CR>", desc = "Files"},
        {"<leader>fg", mode = "n", "<cmd>Telescope live_grep<CR>", desc = "Grep"},
        {"<leader>fb", mode = "n", "<cmd>Telescope buffers<CR>", desc = "Buffers"},
        {"<leader>fd", mode = "n", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics"},
        {"<leader>fl", mode = "n", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Language symbols"},
        {"<leader>ft", mode = "n", "<cmd>TodoTelescope<CR>", desc = "To-Do's"}
    }
}
