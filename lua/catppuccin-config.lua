require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
     comments = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
        operators = { "bold" },
        conditionals = { "bold" },
        loops = { "bold" },
        booleans = { "bold", "italic" },
        numbers = {},
        types = {},
        strings = {},
        variables = {},
        properties = {},   -- miscs = {}, -- Uncomment to turn off hard-coded styles }, color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = false,
        gitsigns = false,
        nvimtree = false,
        treesitter = false,
        notify = false,
        mini = {
            enabled = false,
            indentscope_color = "",
        },
        telescope = { enabled = true, style = "nvchad" },
        which_key = true
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
    highlight_overrides = {
        ---@param cp palette
        all = function (cp)
            return {
                -- For base configs
                NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
                FloatBorder = {
                fg = transparent_background and cp.blue or cp.mantle,
                bg = transparent_background and cp.none or cp.mantle,
                },
                CursorLineNr = { fg = cp.green },

                -- For telescope.nvim
                TelescopeMatching = { fg = cp.lavender },
                TelescopeResultsDiffAdd = { fg = cp.green },
                TelescopeResultsDiffChange = { fg = cp.yellow },
                TelescopeResultsDiffDelete = { fg = cp.red },

            }
        end
        }
    }
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
