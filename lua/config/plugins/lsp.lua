return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "wezterm-types",      mods = { "wezterm" } },
          },
        },
      },
      { 'Bilal2453/luvit-meta',        lazy = true },
      { 'justinsgithub/wezterm-types', lazy = true },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            -- Options related to how notifications are rendered as text
            view = {
              stack_upwards = false,          -- Display notification items from bottom to top
              icon_separator = " ",           -- Separator between group name and icon
              group_separator = "---",        -- Separator between notification groups
              group_separator_hl = "Comment", -- Highlight group used for group separator
            },
            -- Options related to the notification window and buffer
            window = {
              normal_hl = "Comment", -- Base highlight group in the notification window
              winblend = 0,          -- Background color opacity in the notification window
              border = "none",       -- Border around the notification window
              zindex = 45,           -- Stacking priority of the notification window
              max_width = 0,         -- Maximum width of the notification window
              max_height = 0,        -- Maximum height of the notification window
              x_padding = 1,         -- Padding from right edge of window boundary
              y_padding = 0,         -- Padding from bottom edge of window boundary
              align = "top",         -- How to align the notification window
              relative = "editor",   -- What the notification window position is relative to
            },
          },
        }
      },
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
      { 'elixir-tools/elixir-tools.nvim' },
      'stevearc/conform.nvim',
      'b0o/SchemaStore.nvim',
    },
    config = function()
      require 'config.lsp'
    end,
  },
}
