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
}
