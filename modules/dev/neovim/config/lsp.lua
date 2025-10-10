
local bufmap = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { buffer = true })
end

-- vim.lsp.set_log_level("DEBUG")

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})


vim.lsp.enable('hls')
vim.lsp.enable('bashls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('pyright')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
vim.lsp.enable('svelte')
vim.lsp.enable('uiua')
vim.lsp.enable('jdtls')
vim.lsp.enable('serve_d')
vim.lsp.enable('tailwindcss')

vim.lsp.enable('nil_ls')
vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim', 'nixos_config' } },
      workspace = { checkThirdParty = false, }
    }
  }
})

vim.lsp.enable('omnisharp')
vim.lsp.config('omnisharp', {
  cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  organize_imports_on_format = false,
  enable_import_completion = false,
})

vim.lsp.enable('ccls')
vim.lsp.config('ccls', {
  init_options = {
    clang = {
      extraArgs = { "-std=c++20" }
    }
  }
})

local cmds = vim.api.nvim_create_augroup('cmds', { clear = true })
-- Use autocmd to not have to pass on_attach to each setup
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = cmds,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Fix dashes in semantic token types
    if client.name == "omnisharp" then
      local function toSnakeCase(str) return string.gsub(str, "%s*[- ]%s*", "_") end
      local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
      for i, v in ipairs(tokenTypes) do
        tokenTypes[i] = toSnakeCase(v)
      end
    end

    if client.name == "uiua" then
      vim.api.nvim_set_hl(0, '@lsp.type.comment', { fg = '#888888' })
      vim.api.nvim_set_hl(0, '@lsp.type.uiua_number', { fg = '#eeaa55' })
      vim.api.nvim_set_hl(0, '@lsp.type.uiua_string', { fg = '#20f9fc' })
      vim.api.nvim_set_hl(0, '@lsp.type.stack_function', { fg = '#d1daec' })
      vim.api.nvim_set_hl(0, '@lsp.type.noadic_function', { fg = '#ed5e6a' })
      vim.api.nvim_set_hl(0, '@lsp.type.monadic_function', { fg = '#95d16a' })
      vim.api.nvim_set_hl(0, '@lsp.type.dyadic_function', { fg = '#54b0fc' })
      vim.api.nvim_set_hl(0, '@lsp.type.triadic_function', { fg = '#8078f1' })
      vim.api.nvim_set_hl(0, '@lsp.type.tetradic_function', { fg = '#f576d8' })
      vim.api.nvim_set_hl(0, '@lsp.type.monadic_modifier', { fg = '#f0c36f' })
      vim.api.nvim_set_hl(0, '@lsp.type.dyadic_modifier', { fg = '#cc6be9' })
      vim.api.nvim_set_hl(0, '@lsp.type.triadic_modifier', { fg = '#f5a9b8' })
      vim.api.nvim_set_hl(0, '@lsp.type.module', { fg = '#d7be8c' })
      bufmap('n', '<C-R>', '<cmd>term uiua run %<CR>')
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = "Uiua filetype detection",
  group = cmds,
  pattern = "*.ua",
  callback = function()
    vim.opt.filetype = "uiua"
  end
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    svelte = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
  },
})

bufmap("n", "<leader>f", function()
  conform.format({ lsp_fallback = true })
end)

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp", "lua" },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end
})


local sign = function(name, text)
  vim.fn.sign_define(name, {
    texthl = name,
    text = text,
    numhl = ''
  })
end

sign('DiagnosticSignError', '✘')
sign('DiagnosticSignWarn', '▲')
sign('DiagnosticSignHint', '⚑')
sign('DiagnosticSignInfo', '»')
