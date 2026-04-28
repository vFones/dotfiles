-- Editor utilities: clipboard helpers, comment tagging, text surround, commenting
return {

	-- copy-file-path: copy absolute/relative path or filename to clipboard
	{
		"h3pei/copy-file-path.nvim",
		config = function()
			vim.keymap.set("n", "<leader>uyfp", "<CMD>CopyFilePath<CR>", { desc = "Copy file path" })
			vim.keymap.set("n", "<leader>uyfn", "<CMD>CopyFileName<CR>", { desc = "Copy file name" })
			vim.keymap.set("n", "<leader>uyrp", "<CMD>CopyRelativeFilePath<CR>", { desc = "Copy relative file path" })
		end,
	},

	-- TODO:-comments: highlight and search TODO/FIXME/HACK/NOTE comment tags
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info", alt = { "WIP" } },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},

	-- nvim-surround: add/change/delete surrounding pairs (quotes, brackets, tags)
	{
		"kylechui/nvim-surround",
		version = "^4.0.0",
		event = "VeryLazy",
	},

	-- Comment.nvim: toggle line and block comments
	{
		'numToStr/Comment.nvim',
		opts = {},
	},
}
