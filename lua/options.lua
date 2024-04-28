local opt = vim.opt

opt.autowrite = true -- enables automatic saves (writes)
opt.clipboard = 'unnamedplus' -- syncs clipboard with os
opt.completeopt = 'menu,menuone,noselect' 
opt.confirm = true -- confirm to save changes before existing modified buffer
opt.cursorline = true -- highlighting of the current line
opt.expandtab = true -- use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tells vim formatter what to format 
opt.grepformat = '%f:%l:%c:%m' -- how to parse output of external grep tools
opt.grepprg = 'rg --vimgrep' -- program used for :grep operation
opt.ignorecase = true -- ignore case in a pattern
opt.inccommand = 'split' -- show preview of how Ex command will affect text 
opt.incsearch = true -- highlight where search pattern matches as you type
opt.laststatus = 0 -- specifies if last window will have a status line
opt.list = true -- show invisible characters (tabs... )
opt.number = true -- show absolute line numbers of a file
opt.pumblend = 10 -- level of transparency for popup windows
opt.pumheight = 10 -- maximum number of entries in a popup
opt.relativenumber = true -- show relative line numbers
opt.scrolloff = 5 -- amount of line numbers to keep above cursor to show where you are working
opt.sessionoptions = {'buffers', 'curdir', 'tabpages', 'winsize' } -- which session options are included when saving or reloading a session state
opt.shiftround = true -- round indentation to nearest multiple of 'shiftwidth' 
opt.shiftwidth = 4 -- size of indent
-- opt.shortmess:append {W = true, I = true, c = true} -- shorten messages pushed by editor
opt.showmode = false -- hide editor mode since this will be covered by status line plugin
opt.signcolumn = 'yes' -- always show reserved space for signs like breakpoints at side of screen
opt.smartindent = true
opt.tabstop = 4
opt.timeoutlen = 250
opt.mouse = ''
opt.undofile = true
opt.undolevels = 1000
opt.updatetime = 200
opt.wildmode = 'longest:full,full' -- command line completionmode

vim.g.markdown_recommended_style = 0
