require('nvim-treesitter').setup {
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "nix", "python" },
  callback = function() vim.treesitter.start() end,
})
