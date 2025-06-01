-- LSP and completion configuration
local M = {}

-- LSP setup function
function M.setup()
    -- Mason Setup
    require("mason").setup()

    -- LSP Setup
    -- local on_attach = function(_, bufnr)
    --     -- Enable completion triggered by <c-x><c-o>
    --     setup_lsp_keybindings(bufnr)
    -- end

    -- Set up nvim-cmp
    M.setup_cmp()

    -- Set up lspconfig
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

    -- Enable LSP servers
    vim.lsp.enable('pyright')
    vim.lsp.enable('gopls')
    vim.lsp.enable('starpls')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('clangd')
end

-- Completion setup function
function M.setup_cmp()
    local cmp = require('cmp')
    -- local luasnip = require('luasnip')

    -- Load snippets
    -- require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        -- snippet = {
        --     expand = function(args)
        --         luasnip.lsp_expand(args.body)
        --     end,
        -- },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<Down>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                -- elseif luasnip.expand_or_jumpable() then
                --     luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Up>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                -- elseif luasnip.jumpable(-1) then
                --     luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path', keyword_length = 1},
            -- { name = 'luasnip', keyword_length = 2},
            { name = 'buffer', keyword_length = 3},
        },
    })
end

return M
