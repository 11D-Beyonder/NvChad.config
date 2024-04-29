return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      search_workspace = false,
      search = false,
      anaconda_base_path = (vim.loop.os_uname().sysname == "Windows_NT") and "~/AppData/Local/Programs/miniconda3"
        or "~/miniconda3",
      anaconda_envs_path = (vim.loop.os_uname().sysname == "Windows_NT") and "~/AppData/Local/Programs/miniconda3/envs"
        or "~/miniconda3/envs",
      anaconda = {
        python_executable = "python",
        python_parent_dir = (vim.loop.os_uname().sysname == "Windows_NT") and "" or "bin",
      },
    },
    keys = {
      { "<leader>ss", "<cmd>VenvSelect<cr>", desc = "选择venc" },
      -- NOTE: Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
}
