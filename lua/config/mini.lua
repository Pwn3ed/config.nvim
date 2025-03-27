require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.doc').setup()
require('mini.colors').setup()

local move = require('mini.move').move_selection

local set = vim.keymap.set

set({ 'v', 'x' }, '<C-j>', function()
  move('down')
end, { desc = "Move selection Downwards" })

set({ 'v', 'x' }, '<C-k>', function()
  move('up')
end, { desc = "Move selection Upwards" })

set({ 'v', 'x' }, '<C-h>', function()
  move('left')
end, { desc = "Move selection Downwards" })

set({ 'v', 'x' }, '<C-l>', function()
  move('right')
end, { desc = "Move selection Downwards" })

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end
