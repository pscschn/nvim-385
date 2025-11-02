return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<leader>fr",
      mode = "n",
      '<cmd>lua require("spectre").toggle()<CR>',
      desc = "Toggle spectre",
    },
    {

      "<leader>fs",
      mode = "n",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      desc = "Search on current buffer",
    },
  },
  setup = function() end,
}
