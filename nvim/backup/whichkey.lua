local status_ok, which_key = pcall(require, 'which-key')

if not status_ok then
    return
end

local setup = {

    plugins = {
        marks = true, -- shows a list of your marks on ' and  `
        registers = true, -- shows your registers on " in normal or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show Whichkey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list
        },
        -- the presets plugin adds help for different default keybindings 
        presets = {
            operators = false, 
            motions = true, 
            text_objects = true,
            windows = true, 
            nav = true,
            z = true,
            g = true, 
        }
    },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    }, 
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+',  -- symbol prepended t a group 
    }, 
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scrol up inside the popup
    }, 
    window = {
        border = 'rounded',  -- none, single, double, shadow
        position = 'bottom', -- bottom, top 
        margin = {1,0,1,0 }, 
        padding = { 2,2,2,2},
        winblend = 0, 
    },
    layout = {
        height = { min = 4, max = 25 }, 
        width = { min = 20, max = 50 }, 
        spacing = 3, 
        align = 'left', 
    }, 
    ignore_missing = false,  -- hide mappings for which no label is specified explicitly
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate    
    show_help = true, 
    show_keys = true, 
    trigers = 'auto', 
    triggers_nowait = {
        -- marks
        "`",
        "'",
        "g`",
        "g'",
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
    },
    triggers_blacklist = {
        i = {'j', 'k'},
        c = {'j', 'k'}, 
    },
}

local opts = {
    mode = 'n', 
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true, 
    nowait = true
}

local mappings = {
    ['k'] = { '<cmd>bdelete<CR>', 'Kill Buffer'},
    ['p'] = { '<cmd>Lazy<CR>', 'Plugin Manager'}, 
    ['q'] = { '<cmd>wqall!<CR>', 'Quit' }, 
    ['w'] = { '<cmd>w!<CR>', 'Save' },
    ["m"] = { "<cmd>Mason<cr>", "Mason UI for Lsp" },
    ["r"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Reformat Code" },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },

}
which_key.setup(setup)
which_key.register(mappings, opts)


