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

    local registry = require("mason-registry")

    registry:on("package:install:failed", function(pkg)
      vim.api.nvim_echo({ { "Installation failed for" .. pkg.name, "ErrorMsg" } }, true, {})
      vim.notify(string.format("[Mason] Installation failed for %s", pkg.name), vim.log.levels.ERROR)
    end)

    require("mason").setup(opts)
  end,
}
