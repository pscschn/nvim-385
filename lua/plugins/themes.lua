--- Theme switcher
local themery = {
  "zaldih/themery.nvim",
  lazy = false,
  opts = {
    themes = {
      { name = "Catppuccin mocha", colorscheme = "catppuccin" },
      { name = "VS Code", colorscheme = "vscode" },
      { name = "Oldworld", colorscheme = "oldworld" },
    },
    livePreview = true,
  },
}

local catpuccin = {
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
}

local oldworld = {
  "dgox16/oldworld.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "default",
    integrations = {
      telescope = true,
      cmp = true,
    },
  },
  config = function(_, opts)
    require("oldworld").setup(opts)
    --local theme = require ("theme.oldworld")
    --vim.api.nvim_set_hl(0, "Normal", { bg = theme.bg })

    --vim.api.nvim_set_hl(0, "NormalNC", { bg = theme.bg })
    --vim.api.nvim_set_hl(0, "SignColumn", { bg = theme.bg })
    --vim.api.nvim_set_hl(0, "VertSplit", { bg = theme.bg })
    --vim.api.nvim_set_hl(0, "StatusLine", { bg = theme.bg })
  end,
}

local vscode = {
  "Mofiqul/vscode.nvim",
  opts = {
    color_overrides = require("theme.vscode"),
  },
}

--- hightlight color hex's that appear in code
local highlight_colors = {
  "brenoprata10/nvim-highlight-colors",
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
  end,
}
return {
  themery,
  vscode,
  highlight_colors,
  catpuccin,
  oldworld,
}
