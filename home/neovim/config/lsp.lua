local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({ 'rnix', 'tsserver', 'eslint', 'pyright', 'ccls', 'svelte', 'rust_analyzer' })
require('lspconfig').lua_ls.setup(lsp.defaults.nvim_workspace())

lsp.setup()
