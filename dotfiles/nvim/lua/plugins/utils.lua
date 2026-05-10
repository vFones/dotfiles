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

	-- FIXME:
	-- HACK:
	-- NOTE:
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

	-- Snacks is a collection of small, independent Lua modules for Neovim that provide various utilities and enhancements to the editor.
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scroll = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			toggle = { enabled = false },
			gitbrowse = { notify = true },
		},
		keys = {
			{ "<leader>gp", function() Snacks.gitbrowse.open() end, desc = "Open git repo in browser" },
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
}
