-- lua/silas/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Use the 'keys' table to define your keymaps.
  -- This will lazy-load harpoon when you press one of these keys.
  keys = {
    -- This explicitly DISABLES the default LazyVim window-nav keys
    { "<C-h>", false },
    { "<C-j>", false },
    { "<C-k>", false },
    { "<C-l>", false },

    -- These are your harpoon keymaps
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
    { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon quick menu" },
    { "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon nav file 1" },
    { "<C-j>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon nav file 2" },
    { "<C-k>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon nav file 3" },
    { "<C-l>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon nav file 4" },
  },
}
