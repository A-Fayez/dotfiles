local lsp_status = require('lsp-status')
local diagnostic = require('diagnostic')
local completion = require('completion')

local on_attach = function(client)
  completion.on_attach(client)
  diagnostic.on_attach(client)
  lsp_status.on_attach(client)

  vim.api.nvim_command('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 500)')
  vim.api.nvim_command('autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 500)')
  vim.fn.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  vim.fn.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
end

require'nvim_lsp'.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
})

require'nvim_lsp'.pyls.setup({
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  settings = {
      pyls = {
          configurationSources = {"flake8"}
      }
  }
})
