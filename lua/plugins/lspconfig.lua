return {
  "folke/neodev.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("neodev").setup {}
      dofile(vim.g.base46_cache .. "lsp")
      require "nvchad.lsp"
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
      },
    },
  },
}
