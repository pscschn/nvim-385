local get_netcoredbg_path = function()
  return require("lang.csharp").dap.bin
end
return {
  {
    "seblyng/roslyn.nvim",
    lazy = true,
    dependencies = {
      "nvim-neotest/neotest",
      "nsidorenco/neotest-vstest",
      "nvim-treesitter/nvim-treesitter",
    },
    main = "roslyn",
    keys = require("lib.lsp").keys.on_attach,
    --ft = "cs",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c_sharp" },
        sync_install = true,
        auto_install = true,
      })
      require("roslyn").setup(opts)
      require("neotest").setup({
        adapters = {
          require("neotest-vstest")({
            -- table is passed directly to DAP when debugging tests.
            dap_settings = {
              adapter = get_netcoredbg_path(),
            },
            dotnet_additional_args = {
              "-c Debug",
            },
          }),
        },
      })
    end,
  },
}
