-- Terminal: persistent togglable terminal windows with directional split support
return {

	-- toggleterm: float/horizontal/vertical terminal with persistent sessions
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = -30,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "horizontal",
				close_on_exit = true,
				auto_scroll = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 3,
				},
			})
			local Terminal = require('toggleterm.terminal').Terminal
			local gitui    = Terminal:new({
				cmd = "gitui",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _gitui_toggle()
				gitui:toggle()
			end

			vim.api.nvim_set_keymap("n", "<leader>git", "<cmd>lua _gitui_toggle()<CR>", { noremap = true, silent = true })

			local function set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
			_G.set_terminal_keymaps = set_terminal_keymaps
		end,
	},
}
