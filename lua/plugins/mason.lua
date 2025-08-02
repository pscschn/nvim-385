return {
  "williamboman/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  },
  config = function(_, opts)
    opts.registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    }
    require("mason").setup(opts)
  end,
}
