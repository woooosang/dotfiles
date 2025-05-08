require('plugins')
require('config')
require('keybindings')

-- Initialize LSP and completion
require('lsp').setup()

-- Treesitter configuration
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

-- Additional UI setup
require('lualine').setup()
