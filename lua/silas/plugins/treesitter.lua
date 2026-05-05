return {
  -- 1. NVIM-TREESITTER (main plugin)
  {
    "nvim-treesitter/nvim-treesitter",
    
    -- The build command runs :TSUpdate on install/update
    -- This replaces the config = function() vim.cmd([[TSUpdate]]) end
    -- from your original plugins.lua file
    build = ":TSUpdate",

    -- This is the configuration from your after/plugin/treesitter.lua
    config = function()
      if not vim.g.ts_get_node_text_compat then
        local original_get_node_text = vim.treesitter.get_node_text
        vim.treesitter.get_node_text = function(node, source, opts)
          if type(node) == "table" then
            node = node[1]
          end
          if not node then
            return ""
          end
          return original_get_node_text(node, source, opts)
        end
        vim.g.ts_get_node_text_compat = true
      end

      require'nvim-treesitter.configs'.setup {
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang)
            return lang == "markdown" or lang == "markdown_inline"
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },

  -- 2. TREESITTER-CONTEXT (dependency)
  {
    -- This was a separate entry in your plugins.lua
    -- We keep it here as it depends on treesitter
    "nvim-treesitter/nvim-treesitter-context",
  },
}
