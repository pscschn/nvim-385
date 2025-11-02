return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  opts = {
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
      preview = {
        treesitter = false,
      },
    },
  },
  keys = {
    { "<leader>ff", mode = "n", "<cmd>Telescope find_files<CR>", desc = "Files" },
    { "<leader>fg", mode = "n", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    { "<leader>fb", mode = "n", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fd", mode = "n", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    { "<leader>ft", mode = "n", "<cmd>TodoTelescope<CR>", desc = "To-Do's" },
  },
}
