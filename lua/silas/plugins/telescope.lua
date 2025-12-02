return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8', --
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = true,

  config = function() 
      require("telescope")
    end,

  -- Move all keymaps here
  keys = {
    { '<leader>pf', "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { '<C-p>', require('telescope.builtin').git_files, desc = "Git Files" },
    { '<leader>ps', function()
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") });
      end, desc = "Grep String"
    },
    -- This keymap was in remap.lua
    { 'gr', require('telescope.builtin').lsp_references, desc = 'LSP References' },
  },

}
