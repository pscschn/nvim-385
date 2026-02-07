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
      file_ignore_patterns = {
        "%.git/",
        "node_modules/",
        "%.jpg$",
        "%.jpeg$",
        "%.png$",
        "%.gif$",
        "%.o$",
        "%.obj$",
        "%.dll$",
        "%.exe$",
        "%.so$",
      },
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
    {
      vim.g.keys.find.files,
      "<cmd>Telescope find_files<CR>",
      mode = "n",
      desc = "Files",
    },
    {
      vim.g.keys.find.grep,
      "<cmd>Telescope live_grep<CR>",
      mode = "n",
      desc = "Grep",
    },
    {
      vim.g.keys.find.buffers,
      "<cmd>Telescope buffers<CR>",
      mode = "n",
      desc = "Buffers",
    },
    {
      vim.g.keys.find.diagnostics,
      "<cmd>Telescope diagnostics<CR>",
      mode = "n",
      desc = "Diagnostics",
    },
    {
      vim.g.keys.find.todo,
      "<cmd>TodoTelescope<CR>",
      mode = "n",
      desc = "To-Do's",
    },
  },
}
