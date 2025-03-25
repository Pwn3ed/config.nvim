return {
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    priority = 1000,
    init = function()
      require 'config.colorscheme'
    end
  },
  "craftzdog/solarized-osaka.nvim",
  { "rose-pine/neovim", name = "rose-pine" },
}
