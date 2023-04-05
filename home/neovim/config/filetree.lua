local api = require("nvim-tree.api")

local function open_tree()
	api.tree.toggle({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_tree })

vim.keymap.set('n', '<space>n', api.tree.toggle)
