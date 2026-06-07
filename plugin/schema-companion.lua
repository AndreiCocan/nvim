-- Content-aware YAML schema detection. schema-companion.nvim matches a buffer to a
-- schema by its *contents* (e.g. recognizes a Kubernetes manifest from apiVersion/kind),
-- which SchemaStore's filename matching can't do. SchemaStore still handles the
-- well-known filenames (docker-compose, kustomization.yaml, Chart.yaml, GH Actions…).
-- The schema picker uses vim.ui.select (snacks), so telescope is not needed.
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim', -- required by schema-companion
  'https://github.com/cenk1cenk2/schema-companion.nvim',
  'https://github.com/b0o/SchemaStore.nvim', -- filename-based schema catalog
}

local sc = require 'schema-companion'
sc.setup {}

-- Register yamlls config here (not in after/lsp/yamlls.lua): this file loads after
-- mason-lspconfig enables servers but before any YAML buffer opens, so the config is in
-- place when yamlls actually starts — and mason's eager resolve never touches an
-- after/lsp file that requires this not-yet-loaded module. yamlls itself is installed +
-- auto-enabled by mason-lspconfig.
vim.lsp.config(
  'yamlls',
  sc.setup_client(
    sc.adapters.yamlls.setup {
      sources = {
        sc.sources.matchers.kubernetes.setup { version = 'master' }, -- detect k8s by content
        sc.sources.lsp.setup(), -- keep schemas the server already resolved
      },
    },
    {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' }, -- use SchemaStore.nvim, not yamlls' fetcher
          schemas = require('schemastore').yaml.schemas(),
          keyOrdering = false, -- k8s manifests are not alphabetically ordered
          validate = true,
        },
      },
    }
  )
)

-- Pick / inspect the schema for the current YAML buffer.
vim.keymap.set('n', '<leader>cS', function() sc.select_schema() end, { desc = '[C]ode [S]chema (YAML)' })
