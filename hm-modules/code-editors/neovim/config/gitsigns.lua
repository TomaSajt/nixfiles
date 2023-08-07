require('gitsigns').setup()
local signcolumnbg = vim.api.nvim_get_hl(0, { name = "SignColumn" }).bg
vim.api.nvim_set_hl(0, "DiffAdd", { fg = vim.api.nvim_get_hl(0, { name = "DiffAdd" }).fg, bg = signcolumnbg })
vim.api.nvim_set_hl(0, "DiffChange", { fg = vim.api.nvim_get_hl(0, { name = "DiffChange" }).fg, bg = signcolumnbg })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = vim.api.nvim_get_hl(0, { name = "DiffDelete" }).fg, bg = signcolumnbg })
