vim.pack.add {
  'https://github.com/ray-x/guihua.lua', -- floating-window UI lib required by go.nvim
  'https://github.com/ray-x/go.nvim',
}

require('go').setup {
  lsp_cfg = false, -- gopls is already enabled by mason-lspconfig; don't configure it twice
  lsp_inlay_hints = { enable = true }, -- show inlay hints (param names, types)
  trouble = true,
  luasnip = false, -- snippets come from blink.cmp + friendly-snippets
}

-- gofmt + organize imports on save (go.nvim feature). The generic LSP format-on-save
-- in keymaps.lua skips Go so this is the single source of truth for *.go.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('go_format_on_save', { clear = true }),
  pattern = '*.go',
  callback = function() require('go.format').goimports() end,
})

-- Run go.nvim commands from the module root. go test/build must run inside the
-- module (the dir tree with go.mod); if nvim's cwd is elsewhere (e.g. $HOME) the
-- relative package path is rejected. Set a window-local cwd to the nearest go.mod.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('go_module_cwd', { clear = true }),
  pattern = 'go',
  callback = function(ev)
    local fname = vim.api.nvim_buf_get_name(ev.buf)
    if fname == '' then return end
    local root = vim.fs.root(fname, 'go.mod')
    if root and root ~= vim.fn.getcwd() then vim.cmd.lcd(vim.fn.fnameescape(root)) end
  end,
})
