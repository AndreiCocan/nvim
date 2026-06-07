-- Helm support. helm-ls.nvim (by the helm-ls author) sets the `helm` filetype on
-- Chart.yaml / values.yaml / templates so the helm_ls LSP (mason) attaches and yamlls
-- stays off the Go-template `{{ }}` syntax. The `helm` treesitter parser (from the
-- `all` install) handles highlighting. Preferred over towolf/vim-helm, which conflicts
-- with yaml-language-server outside lazy.nvim — and we use vim.pack.
vim.pack.add {
  'https://github.com/qvalentin/helm-ls.nvim',
}

require('helm-ls').setup {}

-- conceal_templates renders `{{ .Values.x }}` as the resolved value via virtual text;
-- conceallevel 2 is required for it to show.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('helm_conceal', { clear = true }),
  pattern = 'helm',
  callback = function() vim.opt_local.conceallevel = 2 end,
})
