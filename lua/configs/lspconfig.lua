local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = function(client, bufnr)
  local map = vim.keymap.set
  local telescope = require "telescope.builtin"
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end
  map("n", "gD", vim.lsp.buf.declaration, opts "go to declaration")
  map("n", "gd", telescope.lsp_definitions, opts "go to definition")
  map("n", "gr", telescope.lsp_references, opts "go to references")
  map("n", "gt", telescope.lsp_type_definitions, opts "go to type definition")
  map("n", "gh", vim.lsp.buf.hover, opts "go to hovered information")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "show signature help")
  map("n", "<leader>lr", function()
    require "nvchad.lsp.renamer"()
  end, opts "rename")
  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "code action")
  if require("nvconfig").ui.lsp.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end
end

local lspconfig = require "lspconfig"
local servers = { "lua_ls", "pyright" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
