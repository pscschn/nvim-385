vim.g.plugins = {
  outline = {
    load = function()
      require("util.plugin").manager.load_plugin("outline.nvim")
    end,
  },
  inline_diagnostic = {
    load = function()
      require("util.plugin").manager.load_plugin("tiny-inline-diagnostic.nvim")
    end,
  },
  dotnet = {
    explorer = false,
    sdk_path = "/usr/share/dotnet/sdk/9.0.112/",
    additional_args = function()
      return {}
    end,
  },
}
