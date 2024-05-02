local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<CR>", { desc = "file save" })
map("n", "<leader>y", "<cmd>%y+<CR>", { desc = "file copy whole" })
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "lsp next diagnostic" })
map("n", "<leader>lD", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
map("n", "<leader>lf", function()
  require("conform").format { timeout = 3000, lsp_fallback = true }
end, { desc = "format files" })
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "comment toggle" })
map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "comment toggle" }
)
