return {
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({})
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({global = false})
                end,
                desc = "Buffer Local Keymaps (which-key)"
            }
        },
        config = function()
            local wk = require("which-key")
            local icons = require("mini.icons")

            local function colored(icon, hl_group)
                return "%#" .. hl_group .. "#" .. icon .. "#%*"
            end
            wk.add(
                {
                    {"<leader>f", group = "Fuzzy Finder"},
                    {"<leader>d", group = "Debug"},
                    {"<leader>m", group = "Marked Files"}
                }
            )
        end
    }
}
