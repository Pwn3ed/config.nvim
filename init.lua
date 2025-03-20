require 'config.config'
require 'config.autocmd'
require 'config.keymaps'
require 'config.lazy'

---@diagnostic disable-next-line: undefined-field
require('lazy').setup {
  change_detection = { notify = false },
  { import = 'custom/plugins' },
  { import = 'config/plugins' },
}
