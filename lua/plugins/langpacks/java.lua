return {
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = function()
			-- calculate workspace dir
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
			vim.fn.mkdir(workspace_dir, "p")

			return {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
					"-configuration",
					vim.fn.expand("$MASON/share/jdtls/config"),
					"-data",
					workspace_dir,
				},
				root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
				settings = {
					java = {
						eclipse = { downloadSources = true },
						configuration = { updateBuildConfiguration = "interactive" },
						maven = { downloadSources = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						inlayHints = { parameterNames = { enabled = "all" } },
						signatureHelp = { enabled = true },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
					},
				},
				init_options = {
					bundles = {
						vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
					},
				},
				filetypes = { "java" },
			}
		end,
		config = function(_, opts)
			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "java", -- autocmd to start jdtls
				callback = function()
					require("jdtls").start_or_attach(opts)
				end,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				pattern = "*.java",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- ensure that only the jdtls client is activated
					if client ~= nil and client.name == "jdtls" then
						require("jdtls.dap").setup_dap_main_class_configs()
					end
				end,
			})
		end,
	},
}
