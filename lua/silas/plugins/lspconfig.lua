return {
  -- 1. MASON: Manages LSP servers, formatters, etc.
  {
    "mason-org/mason.nvim",
    -- This plugin is a dependency for lspconfig,
    -- so we can configure it here.
    opts = {
      -- You can add a list of servers here to ensure they
      -- are automatically installed by Mason.
      -- ensure_installed = {
      --   "gopls",
      --   "templ",
      --   "html",
      --   "lua_ls",
      --   "pyright",
      --   "sqls",
      --   "tsserver",
      -- },
    },
  },

  -- 2. LSPCONFIG: The main LSP configuration
  {
    "neovim/nvim-lspconfig",
    -- This depends on mason to function properly
    dependencies = { "mason-org/mason.nvim" },

    -- All config is now in this function
    config = function()
      -- This 'util' is required for the pyright config you had.
      -- Assuming you're using LazyVim, this is the correct path.
      local util = require("lazyvim.util")

      --
      -- START of code from after/plugin/lsp.lua
      --
      vim.lsp.enable('templ')
      vim.lsp.enable('gopls')
      vim.lsp.enable('html')
      vim.lsp.enable('ts_ls')

      local tmp_cmd = "/Users/silas/go/bin/sqls"
      if vim.fn.exists('g:os') == 0 then
        local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
        if is_windows then
          tmp_cmd = "C:/Users/stompkins9/go/bin/sqls.exe"
        end
      end

      vim.lsp.config('htmx', {
        filetypes = { 'templ', 'html' }
      })

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

      vim.lsp.config('pyright', { on_attach = on_attach, settings = { pyright = { autoImportCompletion = true, }, python = { analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true, typeCheckingMode = 'off' } } } })
      -- basedpyright stuff END

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostics: Open Float" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostics: Prev" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostics: Next" })
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Diagnostics: Set Loclist" })

      -- Keymap from lua/silas/remap.lua
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "LSP: Format" })

      --
      -- MERGED LspAttach Autocommand
      --
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
          
          -- Mappings from after/plugin/lsp.lua
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)

          -- Mapping from lua/silas/remap.lua LspAttach autocmd
          vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = ev.buf, desc = 'LSP: Goto References' })
        end,
      })
      
      --
      -- START of lua_ls config from after/plugin/lsp.lua
      --
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
      --
      -- END of lua_ls config
      --
    end,
  },
}
