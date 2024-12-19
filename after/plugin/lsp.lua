-- Setup language servers.
local util = require 'lspconfig.util'
local configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')
lspconfig.templ.setup {}
lspconfig.gopls.setup {
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git")
}

local tmp_cmd = "/Users/silas/go/bin/sqls"
if vim.fn.exists('g:os') == 0 then
    local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
    if is_windows then
        tmp_cmd = "C:/Users/stompkins9/go/bin/sqls.exe"
    end
end

lspconfig.sqlls.setup {
    on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
    end,
    cmd = { tmp_cmd, "-config", "./sqls_config.yml" },
    root_dir = lspconfig.util.root_pattern('.git', 'config.yml'),
}

require 'lspconfig'.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}
-- lspconfig.phpactor.setup {
-- cmd = {"C:/users/stompkins9/AppData/Local/nvim-data/mason/bin/phpactor.cmd", "language-server"}
-- } this doesnt work because windows is awesome
lspconfig.sourcekit.setup {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
lspconfig.htmx.setup {
    filetypes = { 'templ', 'html' }
}
lspconfig.html.setup {
    filetypes = { 'html' }
}
lspconfig.yamlls.setup {
    filetypes = { 'templ' },
    cmd = { 'templ', 'lsp' }
}

-- basedpyright stuff START
local function organize_imports()
    local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(0) },
    }

    local clients = util.get_lsp_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'pyright',
    }
    for _, client in ipairs(clients) do
        client.request('workspace/executeCommand', params, nil, 0)
    end
end

local function set_python_path(path)
    local clients = util.get_lsp_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'pyright',
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings,
                { python = { pythonPath = path } })
        end
        client.notify('workspace/didChangeConfiguration', { settings = nil })
    end
end

if not configs.basedpyright then
    configs.basedpyright = {
        default_config = {
            cmd = { 'basedpyright-langserver', '--stdio' },
            filetypes = { 'python' },
            root_dir = function(fname)
                return util.root_pattern(unpack({ 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
                    'Pipfile', 'pyrightconfig.json', '.git', }))(fname)
            end,
            single_file_support = true,
            settings = {
                basedpyright = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = 'openFilesOnly',
                    },
                },
            },
        },
        commands = {
            PyrightOrganizeImports = {
                organize_imports,
                description = 'Organize Imports',
            },
            PyrightSetPythonPath = {
                set_python_path,
                description = 'Reconfigure basedpyright with the provided python path',
                nargs = 1,
                complete = 'file',
            },
        },
        docs = {
            description = [[
https://detachhead.github.io/basedpyright

`basedpyright`, a static type checker and language server for python
]],
        },
    }
end

lspconfig.pyright.setup { on_attach = on_attach, settings = { pyright = { autoImportCompletion = true, }, python = { analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true, typeCheckingMode = 'off' } } } }
-- basedpyright stuff END

-- lspconfig.pyright.setup { on_attach = on_attach, settings = { pyright = { autoImportCompletion = true, }, python = { analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true, typeCheckingMode = 'off' } } } }
lspconfig.intelephense.setup {
    filetypes = { 'php', 'block' },
    -- root_dir = lspconfig.util.root_pattern(".git"),
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000,
            },
        }
    }
}
lspconfig.tsserver.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
