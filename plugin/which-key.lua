vim.pack.add {
  'https://github.com/folke/which-key.nvim',
}

local wk = require 'which-key'

wk.setup {
  preset = 'modern',
  delay = function(ctx) return ctx.plugin and 0 or 200 end,
}

wk.add {
  -- leader groups
  { '<leader>b', group = '[B]uffer' },
  { '<leader>c', group = '[C]ode' },
  { '<leader>n', group = '[N]ew' },
  { '<leader>f', group = '[F]ind' },
  { '<leader>g', group = '[G]it' },
  { '<leader>r', group = '[R]efactor' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>u', group = '[U]i' },
  { '<leader>w', group = '[W]indow' },
  { '<leader>x', group = 'Diagnostic[X]' },
  { '<leader><tab>', group = '[tab]' },
  { '<leader>p', group = '[P]roject' },
  { '<leader>q', group = '[Q]uit' },

  -- bracket motions
  { '[', group = 'Prev' },
  { ']', group = 'Next' },
}
