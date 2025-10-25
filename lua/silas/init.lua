require("silas.remap")
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
require("lazy").setup({
	spec = {
		-- 1. Load LazyVim's core plugins

		-- 2. (Optional) Load any LazyVim extras here
		-- { import = "lazyvim.plugins.extras.lang.typescript" },

		-- 3. Load your own custom plugins (from lua/silas/plugins/plugins.lua)
		{ import = "silas.plugins" },
	},
})
