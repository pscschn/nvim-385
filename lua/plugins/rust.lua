return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = true,
  keys = {},
  config = function(_, _)
    vim.keymap.set("n", vim.g.keys.cmp.hover, function()
      vim.cmd.RustLsp({ "hover", "actions" })
    end, { desc = "Hover Action" })
    vim.keymap.set("n", vim.g.keys.lsp.code_action, function()
      vim.cmd.RustLsp("codeAction")
    end, { desc = "Rust Code Action" })

    vim.keymap.set("n", vim.g.keys.lsp.expand_error, function()
      vim.cmd.RustLsp({ "explainError", "cycle" })
    end, { desc = "Explain Error" })

    require("neotest").setup({
      adapters = {
        require("rustaceanvim.neotest"),
      },
    })
  end,
}
