vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- Restrict to specific file types (e.g., "sql")
        local filetype = vim.api.nvim_buf_get_option(ev.buf, "filetype")
        if filetype == "python" then
            vim.keymap.set('n', '<space>f', vim.cmd.Black , { buffer = ev.buf, silent = true })
        end
    end,
})
