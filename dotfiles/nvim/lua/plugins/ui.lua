-- UI chrome: file explorer, keybinding popup, dashboard, scrollbar, window splits
return {

	-- which-key: keybinding popup on prefix hold
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.icons" },
	},

	-- nvim-tree: file explorer sidebar
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		opts = {
			view = {
				width = 40,
			},
		},
		main = "nvim-tree",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "NvimTreeToggle" },
		keys = {
			{ "<leader>et", "<CMD>NvimTreeToggle<CR>",   desc = "NvimTree: toggle" },
			{ "<leader>ee", "<CMD>NvimTreeFocus<CR>",    desc = "NvimTree: focus" },
			{ "<leader>el", "<CMD>NvimTreeFindFile<CR>", desc = "NvimTree: locate file" },
		},
	},

	-- dashboard: startup screen
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},

	-- nvim-scrollbar: visual scrollbar with position indicator
	{ "petertriho/nvim-scrollbar", opts = {} },

	-- smart-splits: seamless navigation between nvim and terminal multiplexer panes
	{ 'mrjones2014/smart-splits.nvim' },
}
