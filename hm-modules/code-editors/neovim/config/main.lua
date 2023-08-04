vim.g.mapleader = " "

vim.cmd.colorscheme("monokai")
vim.opt.termguicolors = true

-- vim.lsp.set_log_level("debug")

-- Allow background transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

local signcolumnbg = vim.api.nvim_get_hl(0, { name = "SignColumn" }).bg
vim.api.nvim_set_hl(0, "DiffAdd", { fg = vim.api.nvim_get_hl(0, { name = "DiffAdd" }).fg, bg = signcolumnbg })
vim.api.nvim_set_hl(0, "DiffChange", { fg = vim.api.nvim_get_hl(0, { name = "DiffChange" }).fg, bg = signcolumnbg })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = vim.api.nvim_get_hl(0, { name = "DiffDelete" }).fg, bg = signcolumnbg })

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


--require("config.statusline")
--vim.cmd("set statusline=%!v:lua.MyStatusLine()")

vim.g['airline#extensions#tabline#enabled'] = true
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
vim.g['airline_theme'] = 'molokai'

vim.g['Hexokinase_optOutPatterns'] = { 'colour_names' }

require('gitsigns').setup()

require("nvim-autopairs").setup {}

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
}
