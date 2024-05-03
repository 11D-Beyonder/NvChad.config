require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank {
      timeout = 300,
    }
  end,
})
autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*",
  callback = function()
    require("venv-selector").retrieve_from_cache()
  end,
  once = true,
})
