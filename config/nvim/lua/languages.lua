-- Language-specific settings for Neovim
local M = {}

function M.setup()
    -- Setup an autocommand group for C/C++ specific settings
    vim.api.nvim_create_augroup('CppSettings', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = 'CppSettings',
        pattern = {'c', 'cpp'},
        callback = function()
            vim.opt_local.expandtab = true
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
        end,
    })

    -- Setup an autocommand group for Python-specific settings
    vim.api.nvim_create_augroup('PythonSettings', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = 'PythonSettings',
        pattern = 'python',
        callback = function()
            -- Set the textwidth to 80 characters for Python files
            vim.opt_local.textwidth = 80
            -- Set colorcolumn to draw a line at the 80 character mark
            vim.opt_local.colorcolumn = '80'
        end,
    })

    -- Setup an autocommand group for Go-specific settings
    vim.api.nvim_create_augroup('GoSettings', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = 'GoSettings',
        pattern = 'go',
        callback = function()
            -- Use tabs for Go files
            vim.opt_local.expandtab = false
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
        end,
    })
end

return M