require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>fm", function()
  require("conform").format { timeout = 3000, lsp_fallback = true }
end, { desc = "Format Files" })
