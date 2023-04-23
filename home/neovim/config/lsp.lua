vim.diagnostic.config({ virtual_text = false })

local lsp = require('lsp-zero').preset({
    float_border = 'rounded',
    call_servers = 'global',
    configure_diagnostics = true,
    setup_servers_on_start = false,
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_basic_mappings = true,
        set_extra_mappings = true,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
    },
})


lsp.default_keymaps({
    preserve_mappings = false
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({
    'rnix',
    'tsserver',
    'eslint',
    'pyright',
    'ccls',
    'rust_analyzer',
    'html',
    'jsonls',
    'svelte',
})

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.defaults.nvim_workspace())

local pid = vim.fn.getpid()

lspconfig.omnisharp.setup {
    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(pid) },
    organize_imports_on_format = false,
    enable_import_completion = false,
}

local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
})

lsp.setup()
