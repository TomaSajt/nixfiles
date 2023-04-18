
-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines in visual mode up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J, but don't move the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- delete without overriding clipboard
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Formatting
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
