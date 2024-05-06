return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "rust-analyzer",
        "pyright",
        "taplo",
        -- Formatter
        "isort",
        "black",
        -- DAP
        "debugpy",
        "codelldb",
      },
    },
  },
}
