vim.pack.add {
  'https://github.com/windwp/nvim-autopairs',
}

require('nvim-autopairs').setup {
  check_ts = true, -- use Treesitter to avoid pairing inside strings/comments
}
