return {
  { "Mofiqul/vscode.nvim" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup()
    end,
  },
  { "nickkadutskyi/jb.nvim" },
  {
    "projekt0n/github-nvim-theme",
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      overrides = function(colors)
        local theme = colors.theme
        return {
          --NormalFloat = { bg = "none" },
          --FloatBorder = { bg = "none" },
          --FloatTitle = { bg = "none" },
          --NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          --LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          --MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      color_overrides = {
        mocha = require("theme.mocha"),
      },
      integrations = {
        telescope = { enabled = true, style = "nvchad" },
      },
    },
    main = "catppuccin",
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        telescope = true,
      },
    },
  },
}
