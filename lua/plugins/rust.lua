return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = true,
  keys = {},
  config = function(_, _)
    vim.keymap.set("n", "K", function()
      vim.cmd.RustLsp({ "hover", "actions" })
    end, { desc = "Hover Action" })
    vim.keymap.set("n", "<leader>ra", function()
      vim.cmd.RustLsp("codeAction")
    end, { desc = "Code Action" })

    vim.keymap.set("n", "<leader>re", function()
      vim.cmd.RustLsp({ "explainError", "cycle" })
    end, { desc = "Explain Error" })

    require("neotest").setup({
      adapters = {
        require("rustaceanvim.neotest"),
      },
    })
  end,
}
