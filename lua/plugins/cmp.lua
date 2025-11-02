return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
  },
  opts = {},
  config = function(_, opts)
    vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-y>"] = cmp.mapping.scroll_docs(-4),
      ["<C-e>"] = cmp.mapping.scroll_docs(4),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" }),
    })
    opts.sources = cmp.config.sources(require("lib.cmp").sources)

    opts.formatting = {
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (strings[2] or "") .. ")"

        return kind
      end,
    }

    opts.matching = { disallow_symbol_nonprefix_matching = false }
    opts.experimental = {}
    opts.experimental.ghost_text = true
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#26233a", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = "#31748f", bg = "#22252A" })
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#26233a", bg = "NONE", italic = true })

    cmp.setup(opts)
  end,
}
