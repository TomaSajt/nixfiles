vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local function get_hl(name)
      return vim.api.nvim_get_hl(0, { name = name, link = false })
    end

    local function set_hl(name, opts)
      vim.api.nvim_set_hl(0, name, opts)
    end

    local signcolumnbg = get_hl("SignColumn").bg

    set_hl('@variable', { link = 'Identifier' })
    set_hl('@variable.bash', { fg = '#85dacc' })

    -- Allow background transparency
    set_hl("Normal", {})
    set_hl("NormalFloat", {})

    set_hl("GitSignsAdd", { fg = get_hl("GitSignsAdd").fg, bg = signcolumnbg })
    set_hl("GitSignsChange", { fg = get_hl("GitSignsChange").fg, bg = signcolumnbg })
    set_hl("GitSignsDelete", { fg = get_hl("GitSignsDelete").fg, bg = signcolumnbg })

    set_hl("DiagnosticSignError", { fg = get_hl("DiagnosticSignError").fg, bg = signcolumnbg })
    set_hl("DiagnosticSignWarn", { fg = get_hl("DiagnosticSignWarn").fg, bg = signcolumnbg })
    set_hl("DiagnosticSignHint", { fg = get_hl("DiagnosticSignHint").fg, bg = signcolumnbg })
    set_hl("DiagnosticSignInfo", { fg = get_hl("DiagnosticSignInfo").fg, bg = signcolumnbg })
  end
})

vim.cmd.colorscheme("monokai")
vim.opt.termguicolors = true
