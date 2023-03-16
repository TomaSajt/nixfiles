set number                          " Line numbers
set clipboard+=unnamedplus          " Clipboard sync with os (using xclip)
set signcolumn=yes                  " Put space before line numbers for special markers
hi NormalFloat ctermfg=LightGrey    " Set telescope background color

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

syntax on
colorscheme monokai
