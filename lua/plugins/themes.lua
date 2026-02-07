return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        { name = "Oldworld", colorscheme = "oldworld" },
      },
      livePreview = true,
    },
  },
  {
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
    end,
  },

  --- hightlight color hex's that appear in code
  {
    "brenoprata10/nvim-highlight-colors",
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
    end,
  },
}
