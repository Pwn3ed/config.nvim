return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local set = vim.keymap.set

    set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = "[H]arpoon [A]dd" })

    set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "[H]arpoon [L]ist" })

    -- set('n', '<leader>hl', function()
    --   local buffers = {}
    --   for _, value in pairs(harpoon.lists) do
    --     local id = value.__harpoon_files._index
    --     table.insert(buffers, id .. " - " .. value.__harpoon_files.items[id].value)
    --   end
    --
    --   table.insert(buffers, "x - Cancel")
    --
    --   vim.ui.select(buffers, {
    --     prompt = 'harpoon',
    --   }, function(choice)
    --     if choice == nil or choice == 'x - Cancel' then
    --       return
    --     end
    --
    --     local striped_id = choice:match '^(%d*)'
    --
    --     harpoon:list():select(tonumber(striped_id))
    --   end)
    -- end, { desc = "[H]arpoon [L]ist" })

    set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = "[H]arpoon [P]revious" })

    set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = "[H]arpoon [N]ext" })

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      set('n', string.format('<leader>h%d', idx), function()
        harpoon:list():select(idx)
      end, { desc = "[H]arpoon buffer [" .. idx .. "]" })
    end
  end,
}
