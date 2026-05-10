-- Debugging: LLDB adapter for Rust, DAP UI panels, and Neotest runner with Elixir adapter
return {

	-- nvim-dap-lldb: LLDB debug adapter providing Rust/C/C++ debug configurations
	{
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap_lldb = require("dap-lldb")
			dap_lldb.setup({
				configurations = {
					{
						rust = {
							name = "Launch",
							type = "lldb",
							request = "launch",
							cargo = { "make", "build" },
							cwd = "${workspaceFolder}",
							stopOnEntry = false,
						},
					},
				},
			})

			local augroup = vim.api.nvim_create_augroup("my.dap_enabled_languages", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				pattern = { "rust" },
				callback = function()
					local dap = require("dap")

					vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
					vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: start/continue" })
					vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP: step over" })
					vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: step into" })
					vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP: step out" })
					vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: toggle REPL" })
				end,
			})
		end,
	},

	-- nvim-dap-ui: UI panels for variables, stack, breakpoints; auto-opens on session start
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = false,
		opts = {},
		config = function(_, opts)
			require("dapui").setup(opts)

			local dap, dapui                                   = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config           = function() dapui.open() end
			dap.listeners.before.launch.dapui_config           = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end
		end,
	},

	-- neotest: test runner framework with Elixir adapter
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"jfpedroza/neotest-elixir",
		},
		init = function()
			require("neotest").setup({
				adapters = {
					require("neotest-elixir"),
				},
			})
		end,
	},
}
