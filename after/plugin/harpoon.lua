local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add these lines to delete conflicting default keymaps
-- We use pcall (protected call) so it doesn't error if the keymap doesn't exist
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")


vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })


vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon nav file 1" })
vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end, { desc = "Harpoon nav file 2" })
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end, { desc = "Harpoon nav file 3" })
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end, { desc = "Harpoon nav file 4" })
