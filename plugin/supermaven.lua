vim.pack.add {
  'https://github.com/supermaven-inc/supermaven-nvim',
}

require('supermaven-nvim').setup {
  disable_keymaps = true,
  ignore_filetypes = {
    snacks_input = true,
    snacks_notif = true,
    snacks_terminal = true,
  },
}
