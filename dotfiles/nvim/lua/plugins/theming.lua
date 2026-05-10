-- Core theming: colorscheme, statusline, tabline, winbar, command-line UI
return {
	-- gruvbox: a warm, retro-inspired colorscheme with support for dimming inactive windows
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			-- terminal_colors = true,
		},
		config = function(opts)
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	-- lualine: statusline with mode, branch, diagnostics, filename, and location
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- local colors = require("kanagawa.colors").setup({ theme = "dragon" })
			-- local p = colors.palette
			-- local t = colors.theme
			--
			-- local kanagawa_dragon = {
			-- 	normal = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonBlue2, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	insert = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonGreen, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	terminal = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonGreen, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	visual = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonViolet, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	replace = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonRed, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	command = {
			-- 		a = { fg = t.ui.bg, bg = p.dragonYellow, gui = "bold" },
			-- 		b = { fg = p.dragonWhite, bg = t.ui.bg_p2 },
			-- 		c = { fg = p.dragonGray, bg = t.ui.bg },
			-- 	},
			-- 	inactive = {
			-- 		a = { fg = p.dragonGray3, bg = t.ui.bg_p1 },
			-- 		b = { fg = p.dragonGray3, bg = t.ui.bg_p1 },
			-- 		c = { fg = p.dragonGray3, bg = t.ui.bg_p1 },
			-- 		x = { fg = p.dragonGray3, bg = p.dragonRed },
			-- 	},
			-- }

			require("lualine").setup({
				options = {
					-- theme = kanagawa_dragon,
					component_separators = '',
					section_separators = { left = '', right = '' },
					globalstatus = true,
				},
				sections = {
					lualine_a = { { 'mode', separator = { left = '' }, left_padding = 0, right_padding = 2 } },
					lualine_b = { 'filename', 'branch' },
					lualine_c = {
						'%=', --[[ add your center components here in place of this comment ]]
					},
					lualine_x = {
						{
							'diagnostics',
							sources = { 'nvim_diagnostic' },
							sections = { 'error', 'warn', 'info', 'hint' },
							-- diagnostics_color = {
							-- 	error = { fg = p.dragonRed, bg = t.ui.bg },
							-- 	warn  = { fg = p.dragonOrange, bg = t.ui.bg },
							-- 	info  = { fg = p.dragonBlue2, bg = t.ui.bg },
							-- 	hint  = { fg = p.dragonAqua, bg = t.ui.bg },
							-- },
							symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
							colored = true,
							update_in_insert = false,
							always_visible = false,
							separator = { left = '' },
						}
					},
					lualine_y = {
						{ 'filetype', left_padding = 0 },
					},
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2, right_padding = 0 },
					},
				},
				inactive_sections = {
					lualine_a = { 'filename' },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'location' },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},


	-- barbar: tabline with open buffers, diagnostics, and buffer-picking mode
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			vim.keymap.set('n', '<leader><up>', '<CMD>BufferPrevious<CR>', { desc = 'Go to previous buffer' })
			vim.keymap.set('n', '<leader><down>', '<CMD>BufferNext<CR>', { desc = 'Go to next buffer' })
			vim.keymap.set('n', '<leader><leader>', '<CMD>BufferPick<CR>', { desc = 'Pick a buffer' })
			vim.keymap.set('n', '<leader>q', '<CMD>BufferClose<CR>', { desc = 'Close a buffer' })
			vim.keymap.set('n', '<leader>bp', '<CMD>BufferPin<CR>', { desc = 'Pin/unpin a buffer' })
			vim.keymap.set('n', '<leader>br', '<CMD>BufferRestore<CR>', { desc = 'Restore a closed buffer' })
			vim.keymap.set('n', '<leader>bon', '<CMD>BufferOrderByName<CR>', { desc = 'Order buffers by name' })
			vim.keymap.set('n', '<leader>bod', '<CMD>BufferOrderByDirectory<CR>', { desc = 'Order buffers by directory' })
			vim.keymap.set('n', '<leader>bob', '<CMD>BufferOrderByBufferNumber<CR>',
				{ desc = 'Order buffers by buffer number' })
			vim.keymap.set('n', '<leader>bca', '<CMD>BufferCloseAllButCurrentOrPinned<CR>',
				{ desc = 'Close all buffers but current/pinned' })
			vim.keymap.set('n', '<leader>bc<left>', '<CMD>BufferCloseBuffersLeft<CR>',
				{ desc = 'Close all buffers to the left' })
			vim.keymap.set('n', '<leader>bc<right>', '<CMD>BufferCloseBuffersRight<CR>',
				{ desc = 'Close all buffers to the right' })
			vim.keymap.set('n', '<leader>bm<left>', '<CMD>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
			vim.keymap.set('n', '<leader>bm<right>', '<CMD>BufferMoveNext<CR>', { desc = 'Move buffer right' })
		end,
		opts = {
			letters = "arstneiogmkhxcdvzuywfplbjq;ARSTNEIOGMKHXCDVZUYWFPLBJQ",
			icons = {
				gitsigns = {
					added = { enabled = true, icon = '+' },
					changed = { enabled = true, icon = '~' },
					deleted = { enabled = true, icon = '-' },
				},
			},
			sidebar_filetypes = {
				NvimTree = true,
			},
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},

	-- dropbar: IDE-style winbar breadcrumbs with symbol picker
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	-- noice: replaces cmdline, messages, and popupmenu with a polished UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
		keys = {
			{ "<leader>uh", "<cmd>Noice history<cr>", desc = "Noice: notification history" },
			{ "<leader>ul", "<cmd>Noice last<cr>",    desc = "Noice: last message" },
			{ "<leader>ud", "<cmd>Noice dismiss<cr>", desc = "Noice: dismiss notifications" },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- nvim-notify: notification renderer used by noice
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.opt.termguicolors = true
			-- require("notify").setup({
			-- 	background_colour = "#181616",
			-- })
			-- vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#C34043" })
			-- vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = "#C34043" })
			-- vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#C34043" })
			-- vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "#C34043" })
			-- vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#DCA561" })
			-- vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = "#DCA561" })
			-- vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#DCA561" })
			-- vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "#DCA561" })
			-- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#6A9589" })
			-- vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#6A9589" })
			-- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#6A9589" })
			-- vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#6A9589" })
			-- vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#625E5A" })
			-- vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = "#625E5A" })
			-- vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#625E5A" })
			-- vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "#625E5A" })
			-- vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#8992A7" })
			-- vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = "#8992A7" })
			-- vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#8992A7" })
			-- vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "#8992A7" })
		end,
	},
}
