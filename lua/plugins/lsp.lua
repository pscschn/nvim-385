return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    lazy = true,
    opts = {
      icons = {
        type = "󰜁 ",
        parameter = "󰏪 ",
        offspec = " ", -- hint kind not defined in official LSP spec
        unknown = " ", -- hint kind is nil
      },
      label = {
        truncateAtChars = 20,
        padding = 1,
        marginLeft = 0,
        sameKindSeparator = ", ",
      },
      extmark = {
        priority = 50,
      },
      autoEnableHints = true,
    }, -- required, even if empty
    config = function(_, opts)
      local endhints = require("lsp-endhints")
      endhints.setup(opts)
      endhints.enable()
    end,
  },
}
