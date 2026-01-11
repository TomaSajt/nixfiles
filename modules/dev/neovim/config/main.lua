vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.opt.winborder = "rounded"

-- Hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always have space before line numbers for markers
vim.opt.signcolumn = "yes"

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 6

vim.opt.updatetime = 50

-- Sync clipboard with os
vim.opt.clipboard:append("unnamedplus")

require('gitsigns').setup {}
require("nvim-autopairs").setup {}
require("ibl").setup {}

vim.g['Hexokinase_optOutPatterns'] = { 'colour_names' }

require('config.telescope')
require('config.treesitter')
require('config.lsp')
require('config.cmp')
require('config.keymap')
require('config.airline')
require('config.color')
