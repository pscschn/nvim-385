vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard:append("unnamedplus")

vim.o.relativenumber = true

vim.opt.termguicolors = true

vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = false,
})

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.lsp.inlay_hint.enable()

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {})
--vim.o.winbar = " "
local data = vim.fn.stdpath("data")
vim.g.dirs = {
  cwd = vim.fn.getcwd(),
  data = data,
  temp = data .. "/tmp",
  dap = data .. "/dap",
  lsp = data .. "/lsp",
  mason = data .. "/mason/packages",
  masonbin = data .. "/mason/bin",
  lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
  project_settings = "./.nvim/settings.lua",
}

vim.g.signs = {
  dap = {
    DapBreakpoint = "󰄯",
    DapBreakpointCondition = "󰯲",
    DapBreakpointRejected = "",
    DapLogPoint = "",
    DapStopped = "",
  },
  diagnostic = {
    type = "󰰦 ",
    parameter = "󰰚 ",
    offspec = " ",
    unknown = " ",
  },
}

vim.g.keys = {
  groups = {
    fuzzy = "<leader>f",
    lang = "<leader>l",
    debug = "<leader>d",
    marks = "<leader>m",
    help = "<leader>?",
    test = "<leader>t",
  },
  dap = {
    toggle_breakpoint = "<F9>",
    continue = "<F5>",
    step_into = "<F11>",
    step_over = "<F10>",
    step_out = "<F12>",
    restart = "<F4>",
    terminate = "<F3>",
    toggle_ui = "<leader>dt",
  },
  diagnostic = {
    list = "<leader>dl",
    float = "<leader>df",
  },
  lsp = {
    toggle_outline = "<leader>lo",
    toggle_explorer = "<leader>le",
    find_refs = "<leader>lr",
    find_impl = "<leader>li",
    find_def = "<leader>ld",
    find_symbol = "<leader>ls",
    rename = "<leader>lR",
    code_action = "<leader>la",
    expand_error = "<leader>le",
  },
  marks = {
    list = "<leader>ml",
    add = "<leader>ma",
    clear = "<leader>mc",
    next = "<C-f>",
    prev = "<C-g>",
  },
  tests = {
    toggle_ui = "<leader>tt",
  },
  find = {
    replace = "<leader>fr",
    open_replace = "<leader>fo",
    open = "<leader>fs",
    files = "<leader>ff",
    grep = "<leader>fg",
    buffers = "<leader>fb",
    diagnostics = "<leader>fd",
    todo = "<leader>ft",
  },
  cmp = {
    select_prev = "<C-k>",
    select_next = "<C-j>",
    scroll_up = "<C-y>",
    scroll_down = "<C-e>",
    accept = "<CR>",
    signature = "<S-k>",
    tab = "<Tab>",
    hover = "K",
  },
}

vim.g.plugins = {
  dotnet = {
    explorer = false,
    sdk_path = "/usr/share/dotnet/sdk/9.0.112/",
  },
}
