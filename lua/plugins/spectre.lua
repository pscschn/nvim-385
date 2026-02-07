return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      vim.g.keys.find.replace,
      mode = "n",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle spectre",
    },
    {

      vim.g.keys.find.open_replace,
      mode = "n",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Search on current buffer",
    },
  },
}
