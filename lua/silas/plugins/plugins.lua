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
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "williamboman/mason.nvim"
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
