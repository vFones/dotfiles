-- Core theming: colorscheme, statusline, tabline, winbar, command-line UI
return {

	-- kanagawa: colorscheme loaded at high priority to avoid flicker
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				local p = colors.palette
				return {
					DiagnosticVirtualTextError = { fg = p.dragonRed },
					DiagnosticVirtualTextWarn  = { fg = p.dragonOrange },
					DiagnosticVirtualTextInfo  = { fg = p.dragonBlue2 },
					DiagnosticVirtualTextHint  = { fg = p.dragonAqua },
					DiagnosticFloatingError    = { fg = p.dragonRed },
					DiagnosticFloatingWarn     = { fg = p.dragonOrange },
					DiagnosticFloatingInfo     = { fg = p.dragonBlue2 },
					DiagnosticFloatingHint     = { fg = p.dragonAqua },
					DiagnosticSignError        = { fg = p.dragonRed },
					DiagnosticSignWarn         = { fg = p.dragonOrange },
					DiagnosticSignInfo         = { fg = p.dragonBlue2 },
					DiagnosticSignHint         = { fg = p.dragonAqua },
				}
			end,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	-- lualine: statusline with mode, branch, diagnostics, filename, and location
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = '',
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
					lualine_b = { 'filename', 'branch' },
					lualine_c = {
						'%=', --[[ add your center components here in place of this comment ]]
					},
					lualine_x = {},
					lualine_y = { 'filetype', 'progress' },
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 },
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

	-- bufferline: tabline with open buffers and diagnostics
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			local status_ok, bufferline = pcall(require, "bufferline")
			if not status_ok then
				return
			end
			vim.opt.termguicolors = true
			bufferline.setup({})
		end,
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
			require("notify").setup({
				background_colour = "#181616",
			})
			vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#C34043" })
			vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = "#C34043" })
			vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#C34043" })
			vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "#C34043" })
			vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#DCA561" })
			vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = "#DCA561" })
			vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#DCA561" })
			vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "#DCA561" })
			vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#6A9589" })
			vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#6A9589" })
			vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#6A9589" })
			vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#6A9589" })
			vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#625E5A" })
			vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = "#625E5A" })
			vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#625E5A" })
			vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "#625E5A" })
			vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#8992A7" })
			vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = "#8992A7" })
			vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#8992A7" })
			vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "#8992A7" })
		end,
	},
}
