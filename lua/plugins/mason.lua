return {
  "zapling/mason-conform.nvim",
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright"
      },
    }
  }
}
