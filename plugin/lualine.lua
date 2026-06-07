vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

require('lualine').setup {
  options = {
    theme = 'auto',      -- follow the active colorscheme (koda)
    globalstatus = true, -- single statusline across all splits
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = string.upper },
    },
    lualine_b = {
      { 'branch' },
      {
        'diff',
      },
    },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
      },
      {
        'filename',
        file_status = true,
        path = 0, -- just the filename
      },
    },
    lualine_x = {
      { 'filetype', colored = false }, -- icon follows the theme instead of the devicon color
    },
    lualine_y = {
      { 'progress' },
    },
    lualine_z = {
      { 'location' },
    },
  },
}
