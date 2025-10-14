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
vim.keymap.set('n', 'nl', function() vim.diagnostic.jump({count=1, float=true}) end)
vim.keymap.set('n', 'Nl', function() vim.diagnostic.jump({count=-1, float=true}) end)

local M = {}

-- LSP keybindings for buffers with LSP attached
function M.setup_lsp_keybindings(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>cg', function() vim.lsp.buf.format { async = true } end, bufopts)
end

--Floaterm
vim.g.floaterm_keymap_new = '<leader>ft'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F7>'

return M
