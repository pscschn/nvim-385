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
    opts = {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          csharp_enable_inlay_hints_for_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
          dotnet_enable_tests_code_lens = true,
        },
      },
    },
    config = function(_, opts)
      require("util.treesitter").install({ "c_sharp" })

      vim.lsp.config("roslyn", opts)

      require("neotest").setup({
        adapters = {
          require("neotest-vstest")({
            sdk_path = vim.g.plugins.dotnet.sdk_path,
            dap_settings = {
              adapter = require("lang.csharp").dap.name,
            },
            build_opts = {
              additional_args = {
                --"-c Debug"
              },
            },
          }),
        },
      })

      require("util.keymaps").lsp.attach()
    end,
  },
  {
    "xentropic-dev/explorer.dotnet.nvim",
    lazy = true,
    enabled = function()
      return vim.g.plugins.dotnet.explorer
    end,
    opts = {
      renderer = {
        width = 30,
        side = "left",
      },
    },
    config = function(_, opts)
      require("dotnet_explorer").setup(opts)
    end,
    keys = {
      { vim.g.keys.lsp.toggle_explorer, "<cmd>ToggleSolutionExplorer<cr>", desc = "Toggle Solution Explorer" },
    },
  },
}
