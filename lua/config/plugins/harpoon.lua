return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = "[H]arpoon [A]dd" })

    vim.keymap.set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "[H]arpoon [L]ist" })

    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = "[H]arpoon [P]revious" })

    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = "[H]arpoon [N]ext" })

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<leader>h%d', idx), function()
        harpoon:list():select(idx)
      end, { desc = "[H]arpoon buffer [" .. idx .. "]" })
    end
  end,
}
