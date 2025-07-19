return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            is_hidden_file = function(name, bufnr)
                return name == ".."
            end
        }
    },
    keys = {
        {
            "-",
            mode = "n",
            function()
                vim.cmd(":Oil")
            end,
            desc = "Open parent directory"
        },
        {
            "gd",
            mode = "n",
            function()
                detail = not detail
                if detail then
                    require("oil").set_columns({"icon", "permissions", "size", "msize"})
                else
                    require("oil").set_columns({"icon"})
                end
            end,
            desc = "Open parent directory"
        }
    },
    -- Optional dependencies
    dependencies = {{"echasnovski/mini.icons", opts = {}}},
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false
}
