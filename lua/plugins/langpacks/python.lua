return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      if vim.fn.has "win32" == 1 then
        path = path .. "/venv/Scripts/python"
      else
        path = path .. "/venv/bin/python"
      end
      require("dap-python").setup(path, opts)
    end,
  },
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
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "[V]env [S]elect" },
      -- NOTE: Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "[V]env Select [C]ached" },
    },
  },
}
