local map = vim.keymap.set
map("t", "<esc>", "<C-\\><C-N>", { desc = "escape terminal mode" })
map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "new horizontal term" })
map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "new vertical window" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "toggle horizontal term" })
map({ "n", "t" }, "<A-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "toggle floating term" })
map("t", "<C-q>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "close term in terminal mode" })
