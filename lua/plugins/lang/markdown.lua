return {
  {
    "techwizrd/render-latex.nvim",
    ft = "markdown",
    opts = {
      image = {
        backend = "kitty",
      },
      render = {
        preset = "compact",
        inline = "content",
        inline_symbols = true,
        live_preview = true,
        hide_on_cmdline = false,
        background = "transparent",
      },
      tmux = {
        install_cleanup_hooks = true,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      latex = {
        enabled = false,
      },
    },
    config = function(_, opts)
      local util = require("util.plugin")
      local tsPlugin = util.treesitter
      tsPlugin.install("html")
      tsPlugin.install("latex")
      tsPlugin.install("markdown")
      tsPlugin.install("markdown_inline")

      --util.test_bin("utftex", "Warning: utftex not installed (provided by libtexprintf)")
      require("render-markdown").setup(opts)
    end,
  },
}
