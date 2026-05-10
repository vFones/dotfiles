-- Diagnostics: pretty diagnostic panels and symbol highlighting via Trouble and illuminate
return {

	-- trouble: side panel for diagnostics, references, and LSP results
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                                   desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                                        desc = "Symbols (Trouble)" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle win.position=right win.size=75<cr>",                         desc = "LSP Definitions/references (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right win.size=75 follow=true<cr>", desc = "LSP Definitions/references with follow (Trouble)" },
		},
	},

	-- vim-illuminate: highlight occurrences of the word under cursor via LSP/treesitter/regex
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = { "lsp", "treesitter", "regex" },
				delay = 100,
				large_file_cutoff = 1000,
				large_file_overrides = {
					providers = { "regex" },
				},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"oil",
					"fugitive",
					"NvimTree",
				},
			})
		end,
	},
}
