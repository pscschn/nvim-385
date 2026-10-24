return {
  "chrisgrieser/nvim-lsp-endhints",
  lazy = true,
  opts = {
    icons = {
      type = vim.g.signs.diagnostic.type,
      parameter = vim.g.signs.diagnostic.parameter,
      offspec = vim.g.signs.diagnostic.offspec,
      unknown = vim.g.signs.diagnostic.unknown,
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
  },
  config = function(_, opts)
    local endhints = require("lsp-endhints")
    endhints.setup(opts)
    endhints.enable()
  end,
}
