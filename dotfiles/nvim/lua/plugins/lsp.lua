-- LSP: server management via Mason, completion via COQ, advanced folding via UFO
return {

	-- mason-lspconfig: bridges Mason and nvim-lspconfig for automatic server setup
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},

	-- nvim-origami: code folding based on LSP syntax tree, with manual override support
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			useLspFoldsWithTreesitterFallback = {
				enabled = true,
				foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
			},
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = {
					character = " ",
					width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
					hlgroup = nil,
				},
				lineCount = {
					template = "%d lines", -- `%d` is replaced with the number of folded lines
					hlgroup = "Comment",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = true, -- requires `gitsigns.nvim`
				disableOnFt = { "snacks_picker_input" }, ---@type string[]
			},
			autoFold = {
				enabled = true,
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			foldKeymaps = {
				setup = false,              -- modifies `h`, `l`, `^`, and `$`
				closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
				scrollLeftOnCaret = false,  -- `^` should scroll left (basically mapped to `0^`)
			},
		},

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},

	-- blink.cmp: AI-assisted code completion with LSP and snippet support, powered by a Rust fuzzy matcher for performance
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },

		version = '1.*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			keymap = { preset = 'default' },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			completion = { documentation = { auto_show = true } },

			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},
}
