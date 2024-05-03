local map = vim.keymap.set
map("t", "<C-x>", "<C-\\><C-N>", { desc = "escape terminal mode" })
map("n", "<leader>tH", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "new horizontal term" })
map("n", "<leader>tV", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "new vertical window" })
map({ "n" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "toggleable vertical term" })
map({ "n" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "toggle horizontal term" })
map({ "n" }, "<leader>tf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "toggle floating term" })
map("n", "<leader>tg", function()
  require("nvchad.term").runner {
    pos = "float",
    id = "floatGit",
    cmd = "lazygit",
    float_opts = { border = "double" },
  }
end, { desc = "toggle lazygit" })
map("t", "<C-q>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "close term in terminal mode" })
map("n", "<leader>tr", function()
  require("nvchad.term").toggle {
    id = "coderunner",
    pos = "float",
    cmd = function()
      local file = vim.fn.expand "%"
      local ft_cmds = {
        python = "python " .. file,
        cpp = "g++ -o out " .. file .. " && ./out",
      }
      return ft_cmds[vim.bo.ft]
    end,
    float_opts = { border = "double" },
  }
end, { desc = "run code" })
