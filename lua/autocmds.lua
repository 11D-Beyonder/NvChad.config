require("nvchad.autocmds")
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		for _, file in ipairs({ "pyproject.toml", "requirements.txt", "main.py" }) do
			local path = vim.fn.findfile(file, vim.fn.getcwd() .. ";")
			if path ~= "" then
				require("venv-selector").retrieve_from_cache()
				break
			end
		end
	end,
	once = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local map = vim.keymap.set
		local telescope = require("telescope.builtin")
		local function opts(desc)
			return { buffer = bufnr, desc = desc }
		end
		map("n", "gD", vim.lsp.buf.declaration, opts("go to declaration"))
		map("n", "gd", telescope.lsp_definitions, opts("go to definition"))
		map("n", "gr", telescope.lsp_references, opts("go to references"))
		map("n", "gt", telescope.lsp_type_definitions, opts("go to type definition"))
		map("n", "gh", function()
			local filetype = vim.bo.filetype
			if vim.tbl_contains({ "vim", "help" }, filetype) then
				vim.cmd("h " .. vim.fn.expand("<cword>"))
			elseif vim.tbl_contains({ "man" }, filetype) then
				vim.cmd("Man " .. vim.fn.expand("<cword>"))
			elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
				require("crates").show_crate_popup()
			else
				vim.lsp.buf.hover()
			end
		end, opts("go to hovered information"))
		map("n", "<leader>ls", vim.lsp.buf.signature_help, opts("show signature help"))
		map("n", "<leader>lr", function()
			require("nvchad.lsp.renamer")()
		end, opts("rename"))
		map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("code action"))
		if require("nvconfig").ui.lsp.signature and client.server_capabilities.signatureHelpProvider then
			require("nvchad.lsp.signature").setup(client, bufnr)
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
	callback = function()
		require("clangd_extensions.inlay_hints").setup_autocmd()
		require("clangd_extensions.inlay_hints").set_inlay_hints()
	end,
})
