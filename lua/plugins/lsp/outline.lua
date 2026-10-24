return {
  "hedyhli/outline.nvim",
  lazy = true,
  config = function()
    vim.keymap.set("n", vim.g.keys.lsp.toggle_outline, "<cmd>Outline<CR>", { desc = "Toggle Outline" })

    require("outline").setup({})
  end,
}
