vim.diagnostic.config({ virtual_text = false })

local lspzero = require('lsp-zero')
local lsp = lspzero.preset({
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

lsp.setup_servers({
    'rnix',
    'hls',
    'tsserver',
    'eslint',
    'pyright',
    'rust_analyzer',
    'html',
    'jsonls',
    'svelte',
    'csharp_ls'
})

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.defaults.nvim_workspace())

lspconfig.ccls.setup {
    init_options = {
        clang = {
            extraArgs = { "-std=c++17" }
        }
    }
}

local cmp = require('cmp')
local cmp_action = lspzero.cmp_action()

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

lsp.setup()
