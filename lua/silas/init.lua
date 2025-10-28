-- lua/silas/init.lua

require("silas.remap") -- We will clean this up in Step 3
require("silas.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.lazyvim_default_keymaps = false

-- VVV CHANGE THIS VVV
require("lazy").setup("silas.plugins", {
  -- Your lazy.setup options here, if any
})
-- ^^^ CHANGE THIS ^^^

vim.g.lazyvim_check_order = false
vim.g.lazyvim_default_keymaps = false
