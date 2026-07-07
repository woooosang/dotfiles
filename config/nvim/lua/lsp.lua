-- LSP and completion configuration
local M = {}

-- LSP setup function
function M.setup()
    -- Mason Setup
    require("mason").setup()

    -- LSP Setup
    vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        settings = {
            python = {
                pythonPath = '/home/wk/repositories/pennybot/.venv/bin/python3',
                analysis = {
                    exclude = {
                        "**/node_modules",
                        "**/bazel*",
                        "**/third_party",
                        "**/external",
                        "**/src",
                    },
                    diagnosticsMode = "openFilesOnly",
                },
            },
        },
    })
    vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        on_attach = function(client, bufnr)
            require('keybindings').setup_lsp_keybindings(bufnr)
        end,
        settings = {
            gopls = {
                directoryFilters = {
                    "-bazel-bin",
                    "-bazel-out",
                    "-bazel-testlogs",
                    "-bazel-pennybot",
                    "-bazel_deps",
                },
            },
        },
    })

    vim.lsp.config('starpls', {
        cmd = { 'starpls' },
        filetypes = { 'bzl' },
    })

    vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                    disable = { 'missing-fields' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
            },
        },
    })

    vim.lsp.config('clangd', {
        cmd = { 'clangd' },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })

    vim.lsp.config('jsonnet-language-server', {
        cmd = { 'jsonnet-language-server' },
        filetypes = { "jsonnet", "libsonnet", "libjsonnet" },
    })

    -- Enable LSP servers
    vim.lsp.enable({
        'pyright',
        'gopls',
        'starpls',
        -- 'lua_ls',
        -- 'clangd',
        -- 'jdtls',
        -- 'jsonnet-language-server',
    })
end



return M
