vim.g.mapleader = " "

vim.cmd.colorscheme("monokai")
vim.opt.termguicolors = true

-- vim.lsp.set_log_level("debug")

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
require('guess-indent').setup {}

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50


--vim.opt.colorcolumn = "80"


require('config.telescope')
require('config.treesitter')
require('config.harpoon')
require('config.lsp')
require('config.keymap')
require('config.gitsigns')
require('config.airline')

vim.g['Hexokinase_optOutPatterns'] = { 'colour_names' }


require("nvim-autopairs").setup {}

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
}
