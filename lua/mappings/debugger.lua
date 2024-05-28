local map = vim.keymap.set
local dap = require "dap"
local ui = require "dapui"
local telescope = require("telescope").extensions.dap
local extension_name = vim.fn.expand("%"):match "%.(.*)"

map("n", "<F5>", extension_name == "rs" and "<cmd>RustLsp debug<cr>" or dap.continue, { desc = "start" })
map(
  "n",
  "<leader>dc",
  extension_name == "rs" and "<cmd>RustLsp debug<cr>" or dap.continue,
  { desc = "start/continue (F5)" }
)
map("n", "<SC-F5>", dap.restart, { desc = "restart" })
map("n", "<leader>dr", dap.restart, { desc = "restart (Ctrl+Shift+F5)" })
map("n", "<F17>", dap.terminate, { desc = "stop" })
map("n", "<leader>dQ", dap.terminate, { desc = "stop (Shift+F5)" })
map("n", "<F6>", dap.pause, { desc = "pause" })
map("n", "<leader>dp", dap.pause, { desc = "pause (F6)" })
map("n", "<leader>dq", dap.close, { desc = "close session" })

map("n", "<F9>", dap.toggle_breakpoint, { desc = "toggle break,point" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint (F9)" })

map("n", "<leader>dx", dap.clear_breakpoints, { desc = "clear breakpoints" })

map("n", "<10>", dap.step_over, { desc = "step over" })
map("n", "<eader>do", dap.step_over, { desc = "step over (F10)" })
map("n", "<11>", dap.step_into, { desc = "step into" })
map("n", "<eader>di", dap.step_into, { desc = "step into (F11)" })
map("n", "<F23>", dap.step_out, { desc = "step out" })
map("n", "<leader>dO", dap.step_out, { desc = "step out (Shift+F11)" })
map("n", "<leader>ds", dap.run_to_cursor, { desc = "run to cursor" })

map("n", "<F21>", function()
  vim.ui.input({ prompt = "Condition: " }, function(condition)
    if condition then
      require("dap").set_breakpoint(condition)
    end
  end)
end, { desc = "conditional breakpoint" })
map("n", "<leader>dB", function()
  vim.ui.input({ prompt = "Condition: " }, function(condition)
    if condition then
      require("dap").set_breakpoint(condition)
    end
  end)
end, { desc = "conditional breakpoint (Shift+F9)" })

map("n", "<leader>du", ui.toggle, { desc = "toggle UI" })
map("n", "<leader>dh", ui.eval, { desc = ",hover evaluation" })
map("v", "<leader>dh", ui.eval, { desc = ",hover evaluation" })
map("n", "<leader>dH", function()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then
      require("dapui").eval(expr, { enter = true })
    end
  end)
end, { desc = "hover evaluation of expression" })
map("n", "<leader>dl", telescope.list_breakpoints, { desc = "list breakpoints" })

if extension_name == "rs" then
  map("n", "<leader>dL", "<cmd>RustLsp debuggables<cr>", { desc = "RustLsp Debuggables" })
else
  map("n", "<leader>dL", telescope.configurations, { desc = "list configurations" })
end
