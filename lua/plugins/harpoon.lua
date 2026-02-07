return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      vim.g.keys.marks.list,
      nil,
      mode = "n",
      desc = "List marks",
    },
    {
      vim.g.keys.marks.add,
      function()
        require("harpoon"):list():add()
      end,
      mode = "n",
      desc = "Add",
    },
    {
      vim.g.keys.marks.clear,
      function()
        require("harpoon"):list():clear()
      end,
      mode = "n",
      desc = "Clear all",
    },
    {
      vim.g.keys.marks.next,
      function()
        require("harpoon"):list():next()
      end,
      mode = "n",
      desc = "Next marked file",
    },
    {
      vim.g.keys.marks.prev,
      function()
        require("harpoon"):list():prev()
      end,
      mode = "n",
      desc = "Prev marked file",
    },
  },
  config = function()
    local harpoon = require("harpoon")
    local conf = require("telescope.config").values
    local pickers = require("telescope.pickers")

    local new_finder = function(harpoon_files)
      return require("telescope.finders").new_table({
        results = harpoon_files.items,
        entry_maker = function(item)
          local icon, _ =
            require("nvim-web-devicons").get_icon(item.value, vim.fn.fnamemodify(item.value, ":e"), { default = true })
          return {
            value = item.value, -- Original file path
            display = string.format("%s %s", icon or "", item.value), -- Icon + file path for display
            ordinal = item.value, -- Used for sorting and filtering
            path = item.value, -- Path for previewer
          }
        end,
      })
    end

    local toggle_telescope = nil
    toggle_telescope = function(harpoon_files)
      local picker = nil
      picker = pickers.new({}, {
        prompt_title = "Marked Files",
        finder = new_finder(harpoon_files),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map("n", "dd", function()
            local state = require("telescope.actions.state")
            local selected_entry = state.get_selected_entry()
            local current_picker = state.get_current_picker(prompt_bufnr)

            table.remove(harpoon_files.items, selected_entry.index)
            current_picker:refresh(new_finder(harpoon:list()))
          end)
          return true
        end,
      })

      picker:find()
    end

    vim.keymap.set("n", vim.g.keys.marks.list, function()
      toggle_telescope(harpoon:list())
    end)
  end,
}
