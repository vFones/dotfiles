-- UI chrome: file explorer, keybinding popup, dashboard, scrollbar, window splits
return {
	-- which-key: keybinding popup on prefix hold
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix"
		},
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
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup {
				view = {
					signcolumn = "yes",
					float = {
						enable = false,
						open_win_config = function()
							local scr_w = vim.opt.columns:get()
							local scr_h = vim.opt.lines:get()
							local tree_w = 80
							local tree_h = math.floor(tree_w * scr_h / scr_w)
							return {
								border = "double",
								relative = "editor",
								width = tree_w,
								height = tree_h,
								col = (scr_w - tree_w) / 2,
								row = (scr_h - tree_h) / 2
							}
						end
					},
					cursorline = false
				},
				modified = {
					enable = true
				},
				renderer = {
					indent_width = 3,
					icons = {
						show = {
							hidden = true
						},
						git_placement = "after",
						bookmarks_placement = "after",
						symlink_arrow = " -> ",
						glyphs = {
							folder = {
								arrow_closed = " ",
								arrow_open = " ",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = ""
							},
							default = "󱓻",
							symlink = "󱓻",
							bookmark = "",
							modified = "",
							hidden = "󱙝",
							git = {
								unstaged = "×",
								staged = "",
								unmerged = "󰧾",
								untracked = "",
								renamed = "",
								deleted = "",
								ignored = "∅"
							}
						}
					}
				},
				filters = {
					git_ignored = true
				},
				hijack_cursor = true,
				sync_root_with_cwd = true
			}
		end,
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
			require('dashboard').setup {
				theme = 'doom',
				disable_move = true,
				config = {
					week_header = {
						enable = true,
					},
					center = {
						{ icon = '  ', desc = 'Find File', action = 'Telescope find_files', key = 'f' },
						{ icon = '  ', desc = 'New File', action = 'enew', key = 'n' },
						{ icon = '  ', desc = 'Find Word', action = 'Telescope live_grep', key = 'w' },
						{ icon = '  ', desc = 'Bookmarks', action = 'Telescope marks', key = 'b' },
						{ icon = '  ', desc = 'Recent Files', action = 'Telescope oldfiles', key = 'r' },
						{ icon = '  ', desc = 'Lazy', action = 'Lazy', key = 'l' },
					},
					footer = {},
					vertical_center = true,
				}
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},

	-- nvim-scrollbar: visual scrollbar with position indicator
	{
		"petertriho/nvim-scrollbar",
		dependencies = { "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
		opts = {},
		config = function()
			require('scrollbar').setup()
			require('gitsigns').setup()
			require('hlslens').setup {
				build_position_cb = function(plist, _, _, _)
					require('scrollbar.handlers.search').handler.show(plist.start_pos)
				end,
			}
			require('scrollbar.handlers.gitsigns').setup()
			require('scrollbar.handlers.search').setup()
		end,
	},

	-- smart-splits: seamless navigation between nvim and terminal multiplexer panes
	{
		'mrjones2014/smart-splits.nvim'
	},
}
