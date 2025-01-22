to change sqls split to vertical, find the nvim-data/lazy/sql.nvim/lua/sqls/commands.lua file and change line 33 to be `vim.cmd('vertical %s pedit %s'):format(mods or '', tempfile))
