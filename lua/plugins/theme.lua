return {
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
      highlight_overrides = {
        LineNr = {
          fg = "#857e72",
        },
      },
    },
    config = function(_, opts)
      require("oldworld").setup(opts)
      vim.cmd.colorscheme("oldworld")
    end,
  },

  --- hightlight color hex's that appear in code
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
    end,
  },
}
