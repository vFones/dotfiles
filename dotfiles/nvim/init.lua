vim.g.mapleader = ","

require("config.lazy")

vim.o.number = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.signcolumn = "yes"

-- Use the terminal's background color instead of the colorscheme's.
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste clipboard text" })

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Exit buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>quitall!<cr>", { desc = "Quitta male" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, silent = true })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, silent = true })
		vim.keymap.set("n", "gD", "gd", { buffer = ev.buf, silent = true, desc = "Go to declaration" })
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			{ buffer = ev.buf, silent = true, desc = "LSP: Go to definition" }
		)
		vim.keymap.set(
			"n",
			"grc",
			vim.lsp.buf.incoming_calls,
			{ buffer = ev.buf, silent = true, desc = "LSP: Go to incoming calls" }
		)
		vim.keymap.set(
			"n",
			"gro",
			vim.lsp.buf.outgoing_calls,
			{ buffer = ev.buf, silent = true, desc = "LSP: Go to outgoing calls" }
		)
		vim.keymap.set(
			"n",
			"grw",
			vim.lsp.buf.workspace_symbol,
			{ buffer = ev.buf, silent = true, desc = "LSP: Go to workspace symbol" }
		)
		vim.keymap.set(
			"n",
			"<leader>dl",
			vim.diagnostic.setloclist,
			{ buffer = ev.buf, silent = true, desc = "LSP: Open diagnostics in location list" }
		)
		vim.keymap.set(
			"n",
			"<leader>dd",
			vim.diagnostic.open_float,
			{ buffer = ev.buf, silent = true, desc = "LSP: Open diagnostics in float" }
		)

		vim.lsp.inlay_hint.enable(true)

		vim.api.nvim_create_user_command("Rename", function(opts)
			vim.lsp.buf.rename(opts.fargs[1])
		end, { nargs = 1 })
		vim.api.nvim_create_user_command("Format", function()
			vim.lsp.buf.format()
		end, {})
	end,
})

local format_on_save_group = vim.api.nvim_create_augroup("my.format_on_save", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = format_on_save_group,
	pattern = { "*" },
	callback = function(ev)
		vim.lsp.buf.format()
	end,
})

local language_local_autocmd_group = vim.api.nvim_create_augroup("my.language_local_commands", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = language_local_autocmd_group,
	pattern = { "elm", "elixir" },
	callback = function()
		vim.treesitter.start()
	end,
})

vim.keymap.set("n", "<leader>un", function()
	if vim.g.notifications_enabled == false then
		vim.g.notifications_enabled = true
		require("noice").enable()
		vim.notify("Notifications enabled", vim.log.levels.INFO)
	else
		vim.g.notifications_enabled = false
		require("noice").disable()
	end
end, { desc = "Toggle notifications" })

vim.api.nvim_set_hl(0, "@comment", { italic = true })

-- Diagnostics: show inline virtual text
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		spacing = 4,
-- 		prefix = "●",
-- 		source = "if_many",
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- })
