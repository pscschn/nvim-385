local catpuccin = {
    "catppuccin/nvim",
    opts = {
        flavour = "mocha",
        background = {
            light = "latte",
            dark = "mocha"
        },
        color_overrides = {
            mocha = require("theme.mocha"),
            frappe = require("theme.custom")
        },
        integrations = {
            telescope = {enabled = true, style = "nvchad"}
        }
    },
    main = "catppuccin"
}

return {
    {
        "Mofiqul/vscode.nvim",
        opts = {
            color_overrides = require("theme.vscode")
        }
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function(_, opts)
            require("nvim-highlight-colors").setup(opts)
        end
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    },
                    dragon = require("theme.dragon")
                }
            },
            overrides = function(colors)
                local theme = colors.theme
                local custom = require("theme.dragon")

                return {
                    NormalFloat = {bg = "none"},
                    FloatBorder = {bg = "none"},
                    FloatTitle = {bg = "none"},
                    --NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                    --LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    --MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    Property = {fg = custom.fg, italic = true},
                    TelescopeTitle = {fg = theme.ui.special, bold = true},
                    TelescopePromptNormal = {bg = theme.ui.bg_p1},
                    TelescopePromptBorder = {fg = theme.ui.bg_p1, bg = theme.ui.bg_p1},
                    TelescopeResultsNormal = {fg = theme.ui.fg_dim, bg = theme.ui.bg_m1},
                    TelescopeResultsBorder = {fg = theme.ui.bg_m1, bg = theme.ui.bg_m1},
                    TelescopePreviewNormal = {bg = theme.ui.bg_dim},
                    TelescopePreviewBorder = {bg = theme.ui.bg_dim, fg = theme.ui.bg_dim}
                }
            end
        }
    },
    catpuccin,
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            variant = "cooler",
            integrations = {
                telescope = true,
                cmp = true
            }
        },
        config = function(_, opts)
            require("oldworld").setup(opts)
        end
    }
}
