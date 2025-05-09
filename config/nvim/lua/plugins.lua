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
	use {
		"loctvl842/monokai-pro.nvim",
		config = function() require("monokai-pro").setup() end
	}
	use { 'NLKNguyen/papercolor-theme', as = 'papercolor' }
	use { 'projekt0n/github-nvim-theme', tag = 'v0.0.7' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true },
		config = function() require('lualine').setup() end
	}

	-- Convenience plugins
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})
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
		commit = 'fcca212c',
		config = function()
			require("oil").setup({
				default_file_explorer = true,
			})
		end
	}

	use 'nvim-tree/nvim-web-devicons'

	-- Terminal
	use 'voldikss/vim-floaterm'
	use 'christoomey/vim-tmux-navigator'

	-- Syntax highlighting & LSP
	use { 'nvim-treesitter/nvim-treesitter-context' }
	use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
	use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

	-- LSP Support
	use { 'neovim/nvim-lspconfig' }
	use {
		'williamboman/mason.nvim',
		run = function()
			pcall(vim.cmd, 'MasonUpdate')
		end,
	}
	use { 'williamboman/mason-lspconfig.nvim' }

	-- Autocompletion
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }

	-- Snippets
	use { 'L3MON4D3/LuaSnip' }
	use { 'saadparwaiz1/cmp_luasnip' }
	use { 'rafamadriz/friendly-snippets' }
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
