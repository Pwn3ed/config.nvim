return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      }
    },
    init = function()
      vim.keymap.set('n', '-', '<cmd>Oil<CR>')
    end,
    dependencies = {
      { 'echasnovski/mini.icons', opts = {} },
    },
  },
}
