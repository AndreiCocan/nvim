-- Buffer tabs along the top. devicons is listed first so it's on the runtimepath
-- before bufferline.setup runs (bufferline.lua sorts before lualine.lua, which would
-- otherwise be the first thing to load devicons). Keymaps live in lua/keymaps.lua.
vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons', -- icons (shared with lualine/snacks)
  'https://github.com/akinsho/bufferline.nvim',
}

require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp', -- show LSP error/warning counts per buffer
    diagnostics_indicator = function(_, _, diag)
      local icons = { error = ' ', warning = ' ' }
      local ret = (diag.error and icons.error .. diag.error .. ' ' or '') .. (diag.warning and icons.warning .. diag.warning or '')
      return vim.trim(ret)
    end,
    -- make room for the Snacks.explorer sidebar instead of overlapping it
    offsets = {
      { filetype = 'snacks_layout_box', text = 'Explorer', highlight = 'Directory', text_align = 'left' },
    },
    show_buffer_close_icons = false,
    always_show_bufferline = false, -- hide the bar when only one buffer is open
  },
}
