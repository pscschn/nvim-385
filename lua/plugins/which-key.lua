return {
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")

      wk.add({
        { vim.g.keys.groups.fuzzy, group = "Fuzzy Finder" },
        { vim.g.keys.groups.lang, group = "Lang" },
        { vim.g.keys.groups.debug, group = "Diagnostic" },
        { vim.g.keys.groups.marks, group = "Marked Files" },
        { vim.g.keys.groups.help, group = "Buffer Keymaps" },
      })
    end,
  },
}
