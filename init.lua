require 'config.config'
require 'config.autocmd'
require 'config.keymaps'
require 'config.lazy'

require('lazy').setup {
  change_detection = { notify = false },
  { import = 'custom/plugins' },
  { import = 'config/plugins' },
}
