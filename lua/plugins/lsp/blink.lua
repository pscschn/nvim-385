return {
  "saghen/blink.cmp",
  version = "1.*",
  --lazy = true,
  event = "BufReadPost",
  opts = {
    keymap = {
      [vim.g.keys.cmp.show_menu] = { "show", "fallback" },
      [vim.g.keys.cmp.select_prev] = { "select_prev" },
      [vim.g.keys.cmp.select_next] = { "select_next" },
      [vim.g.keys.cmp.scroll_up] = { "scroll_documentation_up" },
      [vim.g.keys.cmp.scroll_down] = { "scroll_documentation_down" },
      [vim.g.keys.cmp.accept] = { "accept", "fallback" },

      [vim.g.keys.cmp.signature] = {
        modes = { "n" },
        "show_signature",
        "show_documentation",
        "hide_signature",
        "hide_documentation",
        "fallback",
      },

      [vim.g.keys.cmp.signature] = {
        modes = { "i" },
        "fallback",
      },

      [vim.g.keys.cmp.tab] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },

      documentation = { auto_show = false },

      ghost_text = {
        enabled = false,
      },

      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
      implementation = "lua",
    },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
    local projects = require("util.projects")
    if projects.loaded then
      projects.loaded.config()
    end
  end,
}
