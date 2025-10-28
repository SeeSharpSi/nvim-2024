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
      require'nvim-treesitter.configs'.setup {
        auto_install = true,
        highlight = {
          enable = true,
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
