return {
    "tpope/vim-fugitive",
    config = function()
        local set = vim.keymap.set
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd

        set("n", "<leader>gs", vim.cmd.Git)

        autocmd("BufWinEnter", {
            group = augroup("fugitive", {}),
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                --- ADD REMAPS
            end,
        })
    end
}
