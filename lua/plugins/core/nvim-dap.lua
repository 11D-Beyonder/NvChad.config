return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- CHANGE THIS to your path!
					command = require("mason-registry").get_package("codelldb"):get_install_path() .. (vim.loop
						.os_uname().sysname
						:find("Windows") and "\\extension\\adapter\\codelldb.exe" or "/codelldb"),
					args = { "--port", "${port}" },

					-- On windows you may have to uncomment this:
					-- detached = false,
				},
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "DiagnosticWarn" })
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			dapui.setup(opts)
		end,
	},
}
