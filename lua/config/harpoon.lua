local harpoon = require 'harpoon'
harpoon:setup()

local set = vim.keymap.set

set('n', '<leader>ha', function()
  harpoon:list():add()
end, { desc = "[H]arpoon [A]dd" })

set('n', '<leader>hl', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [L]ist" })

set('n', '<leader>hp', function()
  harpoon:list():prev()
end, { desc = "[H]arpoon [P]revious" })

set('n', '<leader>hn', function()
  harpoon:list():next()
end, { desc = "[H]arpoon [N]ext" })

for i = 1, 5 do
  set('n', string.format('<leader>h%d', i), function()
    harpoon:list():select(i)
  end, { desc = "[H]arpoon buffer [" .. i .. "]" })
end
