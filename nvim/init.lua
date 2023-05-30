require('plugins')
require('config')
require('keybindings')

-- Plugin Settings

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

	local opts = {buffer = bufnr}
	local bind = vim.keymap.set

	bind('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	bind('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
	bind('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

require('lualine').setup()

