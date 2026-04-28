-- Visual appearance: markdown rendering, focus modes, indentation, YAML, word highlighting
return {

	-- render-markdown: rich markdown rendering inside the buffer
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "Avante" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},
		opts = {},
	},

	-- twilight: dims code outside the active function/block
	{
		"folke/twilight.nvim",
		opts = {},
	},
	-- zen-mode: distraction-free centered editing, integrates with twilight
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>z",
				function()
					require("zen-mode").toggle()
				end,
				desc = "ZenMode: toggle",
			},
		},
		opts = {
			window = {
				backdrop = 0.95,
				height = 0.60,
				width = 120,
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
					cursorline = false,
				},
			},
			plugins = {
				twilight = { enabled = true },
				gitsigns = { enabled = false },
				tmux = { enabled = false },
			},
			on_open = function(win)
				require("ibl").update({ enabled = false })
			end,
			on_close = function(win)
				require("ibl").update({ enabled = true })
			end,
		},
	},

	-- yaml-companion: YAML schema detection and yamlls LSP integration
	{
		"mosheavni/yaml-companion.nvim",
		opts = {},
		config = function(_, opts)
			local cfg = require("yaml-companion").setup(opts)
			vim.lsp.config("yamlls", cfg)
			vim.lsp.enable("yamlls")
		end,
	},

	-- vim-illuminate: highlight all occurrences of the word under the cursor
	{ "RRethy/vim-illuminate" },

	-- indent-blankline: indentation guide lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = { enabled = false },
			exclude = {
				filetypes = { "dashboard" },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end
	},
}
