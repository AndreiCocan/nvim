vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' }, -- syntax aware text-objects
  'https://github.com/nvim-treesitter/nvim-treesitter-context', -- sticky context header
}

require('nvim-treesitter').setup {}

-- Parsers to keep installed. Add languages as you need them.
local ensure_installed = {
  'all',
}

require('nvim-treesitter').install(ensure_installed)

-- Re-run parser install/update after the plugin itself updates.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec and ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then require('nvim-treesitter').update() end
  end,
})

-- Enable highlighting + treesitter indentation for any buffer that has a parser.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    local ok, has_parser = pcall(vim.treesitter.language.add, lang)
    if lang and ok and has_parser then
      vim.treesitter.start(args.buf)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Syntax aware text-objects (main branch). Keymaps live in lua/keymaps.lua.
require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true }, -- jump forward to the next text-object if not already inside one
}

-- Sticky scope header showing the enclosing function/class at the top of the window.
require('treesitter-context').setup {
  max_lines = 3, -- limit the context header height
}
