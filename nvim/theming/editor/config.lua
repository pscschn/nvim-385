local Config = {}

function Config.setup()

    require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
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
        integrations = {
            cmp = false,
            gitsigns = false,
            nvimtree = false,
            treesitter = true,
            notify = false,
            mini = {
                enabled = false,
                indentscope_color = "",
            },
            telescope = { enabled = true },
            treesitter_context = true,
            which_key = true
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    --    custom_highlights = function(colors)
    --      return {
    --        TelescopeMatching = { fg = colors.flamingo },
    --        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
    --
    --        TelescopePromptPrefix = { bg = colors.surface0 },
    --        TelescopePromptNormal = { bg = colors.surface0 },
    --        TelescopeResultsNormal = { bg = colors.mantle },
    --        TelescopePreviewNormal = { bg = colors.mantle },
    --        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
    --        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
    --        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
    --        TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
    --        TelescopeResultsTitle = { fg = colors.mantle },
    --        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    --      }
    --    end,
        highlight_overrides = {
            ---@param cp palette
            all = function(cp)
                return {
                    -- For base configs
                    NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
                    FloatBorder = {
                        fg = transparent_background and cp.blue or cp.mantle,
                        bg = transparent_background and cp.none or cp.mantle,
                    },
                    CursorLineNr = { fg = cp.green },

                    -- For telescope.nvim

    --                TelescopeBorder = { fg = '#000'}, 
    --                TelescopeSelectionCaret = { fg = cp.flamingo }, 
    --                TelescopeSelection = { fg = cp.text, bg = cp.surface0, style = "bold" }, 
    --                TelescopeMatching = { fg = cp.blue }, 
    --                TelescopePromptPrefix = { bg = cp.crust }, 
    --                TelescopePromptNormal = { bg = cp.crust}, 
    --                TelescopeResultsNormal = { bg = cp.mantle}, 
    --                TelescopePreviewNormal = { bg = cp.crust }, 
    --                TelescopePromptBorder = { bg = cp.crust, fg = cp.crust }, 
    --                TelescopeResultsBorder = { bg = cp.mantle, fg = cp.crust }, 
    --                TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust }, 
    --                TelescopePromptTitle = { fg = cp.crust }, 
    --                TelescopeResultsTitle = { fg = cp.text }, 
    --                TelescopePreviewTitle = { fg = cp.crust }, 
                    -- For treesitter
                    ["@keyword.return"] = { fg = cp.pink, style = clear },
                    ["@error.c"] = { fg = cp.none, style = clear },
                    ["@error.cpp"] = { fg = cp.none, style = clear },
                } end, 
            },
            }
    })

    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
end

return Config