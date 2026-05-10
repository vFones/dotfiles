-- LSP: server management via Mason, completion via blink.cmp, advanced folding via UFO
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
	-- nvim-ufo: advanced code folding with LSP support, customizable fold text, and easy keybindings
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (' 󰁂 %d '):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, 'MoreMsg' })
				return newVirtText
			end

			vim.o.foldcolumn = '1' -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

			local ufo = require("ufo")
			ufo.setup({
				preview = {
					win_config = {
						border = { '', '─', '', '', '', '─', '', '' },
						winhgghlight = 'Normal:Folded',
						winblend = 0
					},
				},
				fold_virt_text_handler = handler,
			})

			vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
			vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
			vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
			vim.keymap.set('n', 'K', function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end, { desc = 'Peek folded lines' })
		end,
	},
	-- statuscol.nvim: customizable status column for line numbers, fold indicators, and signs, with click actions
	{
		'luukvbaal/statuscol.nvim',
		opts = function()
			local builtin = require('statuscol.builtin')
			return {
				setopt = true,
				-- override the default list of segments with:
				-- number-less fold indicator, then signs, then line number & separator
				segments = {
					{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
					{ text = { '%s' },             click = 'v:lua.ScSa' },
					{
						text = { builtin.lnumfunc, ' ' },
						condition = { true, builtin.not_empty },
						click = 'v:lua.ScLa',
					},
				},
			}
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
			keymap = { preset = 'super-tab' },

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
	-- lazydev.nvim: provides type definitions and documentation for Lua libraries, enhancing LSP features like hover and completion when working with Lua code
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre",
		config = function()
			local function text_format(symbol)
				local fragments = {}

				-- Indicator that shows if there are any other symbols in the same line
				local stacked_functions = symbol.stacked_count > 0
						and (' | +%s'):format(symbol.stacked_count)
						or ''

				if symbol.references then
					local usage = symbol.references <= 1 and 'usage' or 'usages'
					local num = symbol.references == 0 and 'no' or symbol.references
					table.insert(fragments, ('%s %s'):format(num, usage))
				end

				if symbol.definition then
					table.insert(fragments, symbol.definition .. ' defs')
				end

				if symbol.implementation then
					table.insert(fragments, symbol.implementation .. ' impls')
				end

				return table.concat(fragments, ', ') .. stacked_functions
			end
			require("symbol-usage").setup({
				text_format = text_format,
				filetypes = {
					elixir = {
						symbol_request_pos = 'start',
					},
				},
			})
		end,
	}
}
