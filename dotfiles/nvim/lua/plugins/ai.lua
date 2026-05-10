-- AI assistance: GitHub Copilot inline completion and opencode.nvim integration
return {
	-- copilot.vim: inline AI code suggestions; C-J to accept, <leader>j to toggle
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.keymap.set("n", "<leader>j", function()
				if vim.g.copilot_enabled == false then
					vim.cmd("Copilot enable")
					vim.g.copilot_enabled = true
					print("Copilot enabled")
				else
					vim.cmd("Copilot disable")
					vim.g.copilot_enabled = false
					print("Copilot disabled")
				end
			end, { desc = "Toggle Copilot" })

			vim.g.copilot_no_tab_map = true
		end,
	},

	-- opencode.nvim: opencode AI session integration with snacks.nvim picker support
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		dependencies = {
			{
				---@module "snacks"
				"folke/snacks.nvim",
				optional = false,
				opts = {
					input = {},
					picker = {
						actions = {
							opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
				},
			},
		},
		config = function()
			vim.g.opencode_opts = {
				lsp = {
					enabled = true,
					diagnostics = {
						enabled = true,
						update_in_insert = false,
					},
				},
			}

			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
				{ desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
				{ desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
			vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
				{ desc = "Add range to opencode", expr = true })
			vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
				{ desc = "Add line to opencode", expr = true })
		end,
	},
}
