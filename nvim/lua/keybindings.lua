-- Set the leader key to space
vim.g.mapleader = " "

-- Copy to system clipboard
vim.api.nvim_set_keymap("n", "<Leader>y", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", '"+p', { noremap = true, silent = true })

-- Telescope 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sp', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Oil (vinegar-like behavior)
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

vim.keymap.set('n', 'nl', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'Nl', vim.diagnostic.goto_next)
