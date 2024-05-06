dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"
require("neodev").setup {}
for _, lsp in ipairs { "lua_ls", "pyright", "taplo" } do
  require("lspconfig")[lsp].setup {
    on_init = require("nvchad.configs.lspconfig").on_init,
    capabilities = require("nvchad.configs.lspconfig").capabilities,
  }
end
