vim.keymap.del("i", "<C-c>R", { buffer = 0 })
vim.keymap.del("i", "<C-c>l", { buffer = 0 })
vim.keymap.del("i", "<C-c>c", { buffer = 0 })
vim.keymap.del("i", "<C-c>v", { buffer = 0 })
vim.keymap.del("i", "<C-c>p", { buffer = 0 })
vim.keymap.del("i", "<C-c>t", { buffer = 0 })
vim.keymap.del("i", "<C-c>s", { buffer = 0 })
vim.keymap.del("i", "<C-c>T", { buffer = 0 })
vim.keymap.del("i", "<C-c>o", { buffer = 0 })
vim.keymap.del("i", "<C-c>f", { buffer = 0 })
vim.keymap.del("i", "<C-c>k", { buffer = 0 })
vim.keymap.del("i", "<C-c>a", { buffer = 0 })
vim.keymap.del("i", "<C-c>L", { buffer = 0 })
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- Restrict to specific file types (e.g., "sql")
        local filetype = vim.api.nvim_buf_get_option(ev.buf, "filetype")
        if filetype == "sql" then
            vim.keymap.set('n', '<space>f', function()
                -- Get the current buffer content
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                -- Process buffer content with `sleek`
                local formatted = vim.fn.system("sleek", table.concat(lines, "\n"))
                -- Replace the buffer content if the formatter succeeded
                if vim.v.shell_error == 0 then
                    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted, "\n"))
                else
                    vim.notify("Sleek formatting failed: " .. formatted, vim.log.levels.ERROR)
                end
            end, { buffer = ev.buf, silent = true })
        end
    end,
})


-- vim.keymap.set("n", "<leader>f", vim.cmd([[autocmd BufWritePost *.sql silent !sleek %:p]]))
