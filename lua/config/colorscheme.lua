--- 'quiet'|'unokai'|'solarized-osaka'
vim.cmd.colorscheme 'solarized-osaka'

--- Remove background of colorschemes
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  pattern = "*",
  callback = function()
    local keep_background = {
      "solarized-osaka",
    }
    for _, colorscheme in pairs(keep_background) do
      if vim.g["colors_name"] == colorscheme then
        return;
      end
    end

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  end
})

-- local function set_colorscheme(colorscheme)
--   if vim.g["colors_name"] ~= colorscheme then
--     vim.cmd.colorscheme(colorscheme)
--   end
-- end
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--     if vim.bo.filetype == "dashboard" then
--       set_colorscheme("solarized-osaka")
--     end
--   end,
-- })
