
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')


vim.cmd("colorscheme monokai")
vim.cmd("hi NormalFloat ctermfg=LightGrey")

vim.opt.number = true                   -- Hybrid line numbers
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"              -- Always have space before line numbers for markers
vim.opt.colorcolumn = "100"             -- Vertical bar to signal optimal line length
vim.opt.shiftwidth = 4                  -- Tab-space count
vim.opt.clipboard:append("unnamedplus") -- Clipboard sync with os (using xclip)

require("config.statusline")
vim.cmd("set statusline=%!v:lua.MyStatusLine()")

require("nvim-autopairs").setup {}

require("indent_blankline").setup {
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
}

require("config.lspconfig")

