require('plugins')
require('config')
require('keybindings')

-- Initialize LSP and completion
require('lsp').setup()

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "go",
        "lua",
        "python",
    },
    highlight = { enable = true },
    indent = { enable = true },
}

