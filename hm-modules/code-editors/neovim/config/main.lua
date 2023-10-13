vim.g.mapleader = " "

vim.cmd.colorscheme("monokai")
vim.opt.termguicolors = true

-- set to "off" or "debug"
vim.lsp.set_log_level("off")

-- Allow background transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always have space before line numbers for markers
vim.opt.signcolumn = "yes"

-- Sync clipboard with os (using xclip)
vim.opt.clipboard:append("unnamedplus")

-- Tab settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end
})

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50


--vim.opt.colorcolumn = "80"


require('config.telescope')
require('config.treesitter')
require('config.lsp')
require('config.keymap')
require('config.gitsigns')
require('config.airline')

vim.g['Hexokinase_optOutPatterns'] = { 'colour_names' }


require("nvim-autopairs").setup {}

require("ibl").setup {}
