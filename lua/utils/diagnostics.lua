local diagnostics_float_active = false
local diagnostics_lines_active = false

local format_diagnostic = function(diagnostic)
    return diagnostic.message
end

local show_diagnostics_float = function()
    vim.diagnostic.open_float(nil, { focusable = false })
    diagnostics_float_active = true
end

local hide_diagnostics_float = function()
    diagnostics_float_active = false
end

local show_diagnostics_lines = function()
    vim.diagnostic.config { virtual_lines = {
        format = format_diagnostic,
        current_line = true
    } }
    diagnostics_lines_active = true
end

local hide_diagnostics_lines = function()
    vim.diagnostic.config { virtual_lines = false }
    diagnostics_lines_active = false
end

local icons = {
    error = "",
    warn = "",
    info = "",
    hint = "",
}

return {
    icons = icons,
    show_current_line_diagnostics = function()
        if diagnostics_float_active then
            return
        end

        if diagnostics_lines_active then
            hide_diagnostics_lines()
            show_diagnostics_float()
            return
        end

        show_diagnostics_lines()
    end,

    hide_current_line_diagnostics = function()
        hide_diagnostics_float()
        hide_diagnostics_lines()
    end,

    diagnostic_prefix = function(diagnostic, i, total)
        local icons_hls = {
            [vim.diagnostic.severity.ERROR] = { icons.error, "DiagnosticError" },
            [vim.diagnostic.severity.WARN]  = { icons.warn, "DiagnosticWarn" },
            [vim.diagnostic.severity.INFO]  = { icons.info, "DiagnosticInfo" },
            [vim.diagnostic.severity.HINT]  = { icons.hint, "DiagnosticHint" },
        }
        local icon, hl = unpack(icons_hls[diagnostic.severity] or { " ", "" })
        return icon .. " ", hl
    end
}
