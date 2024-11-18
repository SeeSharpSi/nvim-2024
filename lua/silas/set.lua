vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.o.shell = "C:/windows/System32/WindowsPowerShell/v1.0/powershell.exe"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitright = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.filetype.add({ extension = { templ = "templ" } })

vim.filetype.add({ extension = { block = "php" } })

vim.opt.ai = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    command = "setlocal autoindent"
})

vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
