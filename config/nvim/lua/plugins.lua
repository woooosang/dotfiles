-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	-- Visuals
	{ 'andymass/vim-matchup', event = 'VimEnter' },
	{ 'rebelot/kanagawa.nvim' },
	{ 'catppuccin/nvim', name = 'catppuccin' },
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{
		"loctvl842/monokai-pro.nvim",
		config = function() require("monokai-pro").setup() end
	},
	{ 'NLKNguyen/papercolor-theme', name = 'papercolor' },
	{ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function() require('lualine').setup() end
	},

	-- Convenience plugins
	{
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	'tpope/vim-commentary',
	'f-person/git-blame.nvim',
	'jreybert/vimagit',

	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = {
			'nvim-lua/plenary.nvim',
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end
	},
	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	},
	'ntpeters/vim-better-whitespace',

	-- File explorer (netrw substitute)
	{
		'stevearc/oil.nvim',
		commit = 'fcca212c',
		config = function()
			require("oil").setup({
				default_file_explorer = true,
			})
		end
	},

	'nvim-tree/nvim-web-devicons',

	-- Terminal
	'voldikss/vim-floaterm',
	'christoomey/vim-tmux-navigator',

	-- Syntax highlighting & LSP
	{
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end,
    },
	{
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },

	-- LSP Support
	{ 'neovim/nvim-lspconfig' },
	{
		'williamboman/mason.nvim',
		build = function()
			pcall(vim.cmd, 'MasonUpdate')
		end,
	},

	-- Autocompletion
	{
		'saghen/blink.cmp',
		version = 'v1.3.1',
		build = 'cargo build --release',
		config = function()
			require('blink.cmp').setup({
				keymap = { preset = 'default' },
				appearance = {
					nerd_font_variant = 'mono'
				},
				sources = {
					default = { 'lsp', 'path', 'buffer' },
				},
                completion = {
                    documentation = { auto_show = true },
                },
			})
		end
	},

	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function() require('todo-comments').setup() end
	},
	{ 'folke/zen-mode.nvim' },
	{
		'jceb/vim-orgmode',
		dependencies = {
			'tpope/vim-speeddating',
			'inkarkat/vim-SyntaxRange',
		},
	},
    {
        'olimorris/codecompanion.nvim',
        config = function()
            local secrets = require("secrets")
            require("codecompanion").setup({
                opts = {
                    log_level = "DEBUG", -- or "TRACE"
                },
                adapters = {
                    acp = {
                        claude_code = function()
                            return require("codecompanion.adapters").extend("claude_code", {
                                env = {
                                    CLAUDE_CODE_OAUTH_TOKEN = secrets.CLAUDE_CODE_OAUTH_TOKEN,
                                },
                            })
                        end,
                    },
                },
                strategies = {
                    chat = {
                        adapter = "claude_code"
                    },
                    inline = {
                        adapter = "claude_code"
                    },
                    cmd = {
                        adapter = "claude_code"
                    }
                },
            })
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    }
})

