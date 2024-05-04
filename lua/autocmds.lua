require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      timeout = 300,
    }
  end,
})
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    for _, file in ipairs { "pyproject.toml", "requirements.txt", "main.py" } do
      local path = vim.fn.findfile(file, vim.fn.getcwd() .. ";")
      if path ~= "" then
        require("venv-selector").retrieve_from_cache()
        break
      end
    end
  end,
  once = true,
})
