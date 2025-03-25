local set = vim.keymap.set

set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
set("n", "<leader>gc", vim.cmd.Gdiffsplit, { desc = "[G]it [C]hanges" })
