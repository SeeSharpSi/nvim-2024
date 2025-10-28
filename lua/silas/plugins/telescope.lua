-- lua/silas/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2', --
  dependencies = { 'nvim-lua/plenary.nvim' },

  -- Move all keymaps here
  keys = {
    { '<leader>pf', require('telescope.builtin').find_files, desc = "Find Files" },
    { '<C-p>', require('telescope.builtin').git_files, desc = "Git Files" },
    { '<leader>ps', function()
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") });
      end, desc = "Grep String"
    },
    -- This keymap was in remap.lua
    { 'gr', require('telescope.builtin').lsp_references, desc = 'LSP References' },
  },
}
