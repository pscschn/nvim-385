return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    main = "tiny-inline-diagnostic",
    opts = {
        transparent_bg = true,
        transparent_cursorline = true,
        preset = "modern",
        hi = {
            error = "DiagnosticError",
            warn = "DiagnosticWarn",
            info = "DiagnosticInfo",
            hint = "DiagnosticHint",
            arrow = "NonText",
            background = "CursorLine",
            mixing_color = "None"
        },
        multilines = {
            enabled = true
        },
        enable_on_insert = true
    }
}
