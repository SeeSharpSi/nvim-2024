return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            vim.cmd([[TSUpdate]])
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            -- Forcefully delete any conflicting keymaps
            -- This will remove the default <C-h> window navigation
            pcall(vim.keymap.del, "n", "<C-h>")
            pcall(vim.keymap.del, "n", "<C-j>")
            pcall(vim.keymap.del, "n", "<C-k>")
            pcall(vim.keymap.del, "n", "<C-l>")
    
            vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })
    
            -- These will now work without conflict
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon nav file 1" })
            vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end, { desc = "Harpoon nav file 2" })
            vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end, { desc = "Harpoon nav file 3" })
            vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end, { desc = "Harpoon nav file 4" })
        end
    },
    {
        "mason-org/mason.nvim"
    },
    {
        "neovim/nvim-lspconfig"
    },
    {
        "ThePrimeagen/git-worktree.nvim"
    },
    {
        "tpope/vim-fugitive"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/vim-vsnip' }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "mbbill/undotree",
    },
    {
        "nanotee/sqls.nvim",
    },
    {
        "yuchanns/phpfmt.nvim",
    },
    {
        "psf/black",
    },
    {
        "stsewd/isort.nvim",
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        words = { enabled = true },
      },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
        lazy = false, -- neo-tree will lazily load itself
    },
}
