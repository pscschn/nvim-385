return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = true,
  keys = {
    --{ "<leader>ra", mode = "n", function()
    --vim.cmd.RustLsp('codeAction')
    --end, desc = "Rust action" },
    --{ "K", mode = "n", function()
    --vim.cmd.RustLsp({"hover", "actions"})
    --end
    --}
  },
  config = function(_, opts)
    require("which-key").add({ "<leader>l", group = "Rust" })

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