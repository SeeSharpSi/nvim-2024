-- vim.keymap.set("n", "<leader>f", vim.cmd('%!pint'))
vim.keymap.set("n", "<leader>f", vim.cmd([[autocmd BufWritePost *.php silent !./vendor/bin/pint %:p]]))
