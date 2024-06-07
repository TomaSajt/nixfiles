-- set to "off" or "debug"
vim.lsp.set_log_level("off")

vim.g.mapleader = " "

-- Hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always have space before line numbers for markers
vim.opt.signcolumn = "yes"

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

require('gitsigns').setup()
require('config.telescope')
require('config.treesitter')
require('config.lsp')
require('config.cmp')
require('config.keymap')
require('config.airline')
require('config.color')

vim.g['Hexokinase_optOutPatterns'] = { 'colour_names' }

require("nvim-autopairs").setup {}

require("ibl").setup {}
