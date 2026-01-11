vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local function get_hl(name)
      return vim.api.nvim_get_hl(0, { name = name, link = false })
    end

    local function set_hl(name, opts)
      vim.api.nvim_set_hl(0, name, opts)
    end

    set_hl('@variable', { link = 'Identifier' })
    set_hl('@variable.bash', { fg = '#85dacc' })

    -- Allow background transparency
    set_hl("Normal", {})
    set_hl("NormalFloat", {})
  end
})

vim.cmd.colorscheme("monokai")
vim.opt.termguicolors = true
