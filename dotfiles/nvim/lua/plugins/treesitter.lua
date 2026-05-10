-- Treesitter: syntax parsing/highlighting and inline context breadcrumbs
return {

	-- nvim-treesitter: syntax parsing, highlighting, and language parser management
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install({
				"rust",
				"elixir",
				"elm",
				"clojure",
				"markdown",
				"javascript",
				"typescript",
				"html",
				"css",
				"scss",
				"gleam",
				"haskell",
				"dockerfile",
				"lua",
				"go",
				"hurl",
				"json",
				"regex",
				"php",
				"proto",
				"python",
				"sql",
				"bash",
				"zsh",
				"yaml",
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				desc = "Treesitter: autostart highlighting",
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
			vim.keymap.set("n", "<leader>ls", function()
				vim.treesitter.start()
			end, { desc = "Treesitter: start" })
			vim.keymap.set("n", "<leader>lS", function()
				vim.treesitter.stop()
			end, { desc = "Treesitter: stop" })
		end,
	},

	-- nvim-treesitter-context: sticky context line showing current scope at top of window
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		cmd = "TSContext",
		-- autostart
		keys = {
			{
				"[c",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Treesitter: context up",
			},
			{
				"<leader>lc",
				function()
					require("treesitter-context").toggle()
				end,
				desc = "Treesitter: Toggle context",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true

			-- Or, disable per filetype (add as you like)
			-- vim.g.no_python_maps = true
			-- vim.g.no_ruby_maps = true
			-- vim.g.no_rust_maps = true
			-- vim.g.no_go_maps = true
		end,
		config = function()
			-- put your config here
		end,
	},
}
