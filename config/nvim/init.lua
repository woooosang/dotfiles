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

local function file_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('mason-lspconfig').setup({
	handlers = {
		lsp.default_setup,
		pyright = function()
			require('lspconfig').pyright.setup({
				settings = {
					python = {
						pythonPath = '/home/woosangkang/.pyenv/shims/python3',
					},
				},
			})
		end,
		gopls = function()
		  local config = {
			settings = {
			  gopls = {
				directoryFilters = {
				  "-bazel-bin",
				  "-bazel-out",
				  "-bazel-testlogs",
				  "-bazel-mypkg",
				},
			  },
			},
		  }

		  local gopackagesdriver_path = './tools/gopackagesdriver.sh'
		  if file_exists(gopackagesdriver_path) then
			config.settings.gopls.env = {
			  GOPACKAGESDRIVER = gopackagesdriver_path
			}
		  end
		  require('lspconfig').gopls.setup(config)
		end,
	}
})

lsp.setup()

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"bash",
		"go",
		"lua",
		"python",
	},
	highlight = { enable = true },
	indent = { enable = true }
}

-- Autocomplete config
cmp.setup(
	{
		mapping = {
			['<C-j>'] = cmp.mapping.select_next_item(cmp_select_opts),
			['<C-k>'] = cmp.mapping.select_prev_item(cmp_select_opts),
		}
	}
)

require('lualine').setup()

require('neogit').setup({})
