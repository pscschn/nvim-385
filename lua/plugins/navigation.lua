local show_detail = false

return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        is_hidden_file = function(name, _)
          return name == ".."
        end,
      },
    },
    keys = {
      {
        vim.g.keys.file_tree.up,
        mode = "n",
        function()
          vim.cmd(":Oil")
        end,
        desc = "Open parent directory",
      },
      {
        vim.g.keys.file_tree.detail_toggle,
        mode = "n",
        function()
          show_detail = not show_detail
          if show_detail then
            require("oil").set_columns({ "icon", "permissions", "size", "msize" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
        desc = "Open parent directory",
      },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  },
  {
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
  },
  {
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
    },
  },
}
