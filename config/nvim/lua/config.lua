-- Enable syntax highlighting
vim.cmd("syntax on")

-- Set the tab size to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

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
vim.cmd("colorscheme catppuccin")

-- Set the default indentation settings for C++ files
vim.cmd([[
  augroup c_indentation
    autocmd!
    autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4
  augroup END
]])

vim.g.gitblame_ignored_filetypes = {'oil'}

vim.g.mkdp_theme = 'dark'
