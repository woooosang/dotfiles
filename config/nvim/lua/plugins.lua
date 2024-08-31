-- bootstrapping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- Visuals
	use { 'andymass/vim-matchup', event = 'VimEnter' }
	use { 'rebelot/kanagawa.nvim' }
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use { 'rose-pine/neovim', as = 'rose-pine'}
	use { 'NLKNguyen/papercolor-theme', as = 'papercolor' }
	use { 'projekt0n/github-nvim-theme', tag = 'v0.0.7' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true },
		config = function() require('lualine').setup() end
	}

	-- Convenience plugins
	 use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install',
		setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, })
	use 'tpope/vim-commentary'
	use 'f-person/git-blame.nvim'
	use 'jreybert/vimagit'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use 'ntpeters/vim-better-whitespace'

	-- File explorer (netrw substitute)
	use {
		'stevearc/oil.nvim',
		config = function()
			require("oil").setup({
				columns = {
					"permissions",
					"type",
					-- "icon",
					"size",
					"mtime",
				},
				view_options = {
					sort = {
					  -- sort order can be "asc" or "desc"
					  -- see :help oil-columns to see which columns are sortable
					  { "type", "asc" },
					  { "name", "asc" },
					},
				}
			})
		end
	}

	-- Magit-like experience in nvim
	use {
		'NeogitOrg/neogit', tag = 'v0.0.1',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'sindrets/diffview.nvim' },
			{ 'nvim-telescope/telescope.nvim' },
		},
		config = true,
	}

	use 'nvim-tree/nvim-web-devicons'

	-- Terminal
	use 'voldikss/vim-floaterm'
	use 'christoomey/vim-tmux-navigator'

	-- Syntax highlighting & LSP
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-context' }
	use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
				-- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },    -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	}
	use {
		'folke/todo-comments.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function() require('todo-comments').setup() end
	}
	use { 'folke/zen-mode.nvim' }
	use {
		'jceb/vim-orgmode',
		requires = {
			'tpope/vim-speeddating',
			'inkarkat/vim-SyntaxRange',
		},
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
