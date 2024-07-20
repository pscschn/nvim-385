local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require('telescope.builtin')
local fb_actions = require "telescope._extensions.file_browser.actions"

vim.keymap.set(
"n",
"<leader>fl",
'<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
{ desc = "Live Grep Code" }
)

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find Files'})

vim.keymap.set("n", "<leader>fg", builtin.grep_string, { desc = "Search for selected string" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })		
vim.keymap.set("n", "<leader>mp", builtin.man_pages, { desc = "List man page entries" })
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", {desc = 'Telescope file browser'})



local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        initial_mode = "insert",
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        results_title = false,
        layout_strategy = "vertical",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        color_devicons = true,
        file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip", "node_modules/" },
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_make,
        border = {}, 
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        use_less =true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil
        winblend = 0,
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {

                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
            --   picker_config_ key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extension_list = { "themes", "terms"},
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                },
                advanced_git_search = {
                    -- Configuration options for the extension, if any
                }, 
                file_browser = {
                    path = vim.loop.cwd(),
                    cwd = vim.loop.cwd(),
                    cwd_to_path = false,
                    grouped = false,
                    files = true,
                    add_dirs = true,
                    depth = 1,
                    auto_depth = false,
                    select_buffer = false,
                    hidden = { file_browser = false, folder_browser = false },
                    respect_gitignore = vim.fn.executable "fd" == 1,
                    no_ignore = false,
                    follow_symlinks = false,
                    browse_files = require("telescope._extensions.file_browser.finders").browse_files,
                    browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
                    hide_parent_dir = false,
                    collapse_dirs = false,
                    prompt_path = false,
                    quiet = false,
                    dir_icon = "",
                    dir_icon_hl = "Default",
                    display_stat = { date = true, size = true, mode = true },
                    hijack_netrw = false,
                    use_fd = true,
                    git_status = true,
                    mappings = {
                        ["i"] = {
                            ["<A-c>"] = fb_actions.create,
                            ["<S-CR>"] = fb_actions.create_from_prompt,
                            ["<A-r>"] = fb_actions.rename,
                            ["<A-m>"] = fb_actions.move,
                            ["<A-y>"] = fb_actions.copy,
                            ["<A-d>"] = fb_actions.remove,
                            ["<C-o>"] = fb_actions.open,
                            ["<C-g>"] = fb_actions.goto_parent_dir,
                            ["<C-e>"] = fb_actions.goto_home_dir,
                            ["<C-w>"] = fb_actions.goto_cwd,
                            ["<C-t>"] = fb_actions.change_cwd,
                            ["<C-f>"] = fb_actions.toggle_browser,
                            ["<C-h>"] = fb_actions.toggle_hidden,
                            ["<C-s>"] = fb_actions.toggle_all,
                            ["<bs>"] = fb_actions.backspace,
                        },
                        ["n"] = {
                            ["c"] = fb_actions.create,
                            ["r"] = fb_actions.rename,
                            ["m"] = fb_actions.move,
                            ["y"] = fb_actions.copy,
                            ["d"] = fb_actions.remove,
                            ["o"] = fb_actions.open,
                            ["g"] = fb_actions.goto_parent_dir,
                            ["e"] = fb_actions.goto_home_dir,
                            ["w"] = fb_actions.goto_cwd,
                            ["t"] = fb_actions.change_cwd,
                            ["f"] = fb_actions.toggle_browser,
                            ["h"] = fb_actions.toggle_hidden,
                            ["s"] = fb_actions.toggle_all,
                        },
                    },
                },
            }

        })


