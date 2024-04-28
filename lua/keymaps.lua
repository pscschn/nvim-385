local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', 'U', '<C-r>', opts)

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- left window
keymap("n", "<C-k>", "<C-w>k", opts) -- up window
keymap("n", "<C-j>", "<C-w>j", opts) -- down window
keymap("n", "<C-l>", "<C-w>l", opts) -- right window

-- resize with arrows when using multiple windows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<c-down>', ':resize +2<cr>', opts)
keymap('n', '<c-right>', ':vertical resize -2<cr>', opts)
keymap('n', '<c-left>', ':vertical resize +2<cr>', opts)

-- navigate buffer
keymap('n', '<tab>', ':bnext<cr>', opts)
keymap('n', '<s-tab>', ':bprevious<cr>', opts)
keymap('n', '<leader>h', ':nohlsearch<cr>', opts)

-- move text up and down
keymap('n', '<a-j>', '<esc>:m .+1<cr>==gi<esc>', opts) -- Alt-j
keymap('n', '<a-k>', '<esc>:m .-2<cr>==gi<esc>', opts) -- Alt-k

-- visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts) -- Right Indentation
keymap("v", ">", ">gv", opts) -- Left Indentation

-- move text up and down
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "<a-k>", ":m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
    --Terminal --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
