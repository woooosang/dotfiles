-- LSP and completion configuration
local M = {}

-- LSP setup function
function M.setup()
    -- Mason Setup
    require("mason").setup()

    -- LSP Setup
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    -- Set up nvim-cmp
    M.setup_cmp()

    -- Set up lspconfig
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Setup mason-lspconfig
    require('mason-lspconfig').setup({
        ensure_installed = {
            "lua_ls",
            "pyright",
            "gopls",
        },
        handlers = {
            -- Default handler for all servers
            function(server_name)
                require("lspconfig")[server_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,

            -- Custom handler for pyright
            ["pyright"] = function()
                require("lspconfig").pyright.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        python = {
                            pythonPath = '/home/wk/repositories/pennybot/.venv/bin/python3',
                            analysis = {
                                exclude = {
                                    "**/node_modules",
                                    "**/bazel-*",
                                    "**/third_party",
                                },
                            },
                        },
                    },
                })
            end,

            -- Custom handler for gopls
            ["gopls"] = function()
                require("lspconfig").gopls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            directoryFilters = {
                                "-bazel-bin",
                                "-bazel-out",
                                "-bazel-testlogs",
                                "-bazel-mypkg",
                            },
                        },
                    },
                })

                -- Setup starpls
                require("lspconfig").starpls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,

            -- Custom handler for lua_ls
            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' }
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                })
            end,
        },
    })
end

-- Completion setup function
function M.setup_cmp()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
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
            { name = 'luasnip', keyword_length = 2},
            { name = 'buffer', kehword_length = 3},
        },
    })
end

return M
