-- Set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Copy to system clipboard
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sp', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

--Oil (vinegar-like behavior)
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- LSP
vim.keymap.set('n', 'nl', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'Nl', vim.diagnostic.goto_next)

--Floaterm
vim.g.floaterm_keymap_new = '<leader>ft'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F7>'
