-- Enable syntax highlighting
vim.cmd("syntax on")

-- Use spaces instead of tabs by default (4 spaces per tab)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Set the default file encoding to UTF-8
vim.opt.encoding = "UTF-8"

-- Use relative line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Automatically indent new lines
vim.opt.autoindent = true

-- Use smart tabbing
vim.opt.smarttab = true

-- Ignore case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable line wrapping
vim.opt.wrap = false

-- Show hidden characters
vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    trail = "•",
    extends = "⟩",
    precedes = "⟨",
    nbsp = "␣",
}

-- Highlight search results
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- -- Enable backup and swap files
vim.opt.backup = false
vim.opt.swapfile = false
-- vim.opt.backupdir = "~/.vim/backup"
-- vim.opt.directory = "~/.vim/swap"

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("catppuccin").setup({
	transparent_background = true
})
-- vim.cmd("colorscheme catppuccin-latte")

require("rose-pine").setup({
	styles = {
		transparency = true,
	},
})
vim.cmd("colorscheme rose-pine-moon")


vim.g.gitblame_ignored_filetypes = {'oil'}

vim.g.mkdp_theme = 'light'
vim.g.mkdp_browser = '/snap/bin/firefox'
vim.g.mkdp_echo_preview_url = 1

vim.opt.clipboard:append { 'unnamedplus' }

-- Initialize language-specific settings
require('languages').setup()

