-- Git integration: hunk signs/blame via gitsigns, remote URL sharing, and lazygit TUI
return {

	-- gitsigns: gutter hunk signs, inline blame, stage/reset hunk actions
	{
		"lewis6991/gitsigns.nvim",
		opts = { current_line_blame = true },
		event = "BufRead",
		keys = function()
			return {
				{
					"<leader>gtd",
					function() require("gitsigns.actions").toggle_deleted() end,
					desc = "Gitsigns: toggle deleted",
				},
				{
					"<leader>gtw",
					function() require("gitsigns.actions").toggle_word_diff() end,
					desc = "Gitsigns: toggle word diff",
				},
				{
					"<leader>gtp",
					function() require("gitsigns.actions").preview_hunk_inline() end,
					desc = "Gitsigns: preview hunk inline",
				},
				{
					"ghs",
					function() require("gitsigns.actions").stage_hunk() end,
					desc = "Gitsigns: stage hunk",
					mode = { "n" },
				},
				{
					"ghs",
					function() require("gitsigns.actions").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					desc = "Gitsigns: stage hunk",
					mode = { "v" },
				},
				{
					"ghu",
					function() require("gitsigns.actions").undo_stage_hunk() end,
					desc = "Gitsigns: undo stage hunk",
					mode = { "n" },
				},
				{
					"ghr",
					function() require("gitsigns.actions").reset_hunk() end,
					desc = "Gitsigns: reset hunk",
					mode = { "n" },
				},
				{
					"ghr",
					function() require("gitsigns.actions").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					desc = "Gitsigns: reset hunk",
					mode = { "v" },
				},
			}
		end,
	},

	-- gitportal: copy or open remote git URLs from the editor
	{
		"trevorhauter/gitportal.nvim",
		config = function()
			local gitportal = require("gitportal")

			gitportal.setup({
				switch_branch_or_commit_upon_ingestion = "never",
			})
			vim.keymap.set(
				{ "n", "v" },
				"<leader>gy",
				gitportal.copy_link_to_clipboard,
				{ desc = "GitPortal: copy link to clipboard" }
			)
			vim.keymap.set({ "n", "v" }, "<leader>gp", function()
				local git_utils = require("gitportal.git")
				local url_utils = require("gitportal.url_utils")

				local clipboard_content = vim.fn.getreg("+")
				if clipboard_content ~= nil then
					local parsed_url = url_utils.parse_githost_url(clipboard_content)
					if parsed_url ~= nil then
						git_utils.open_file_from_git_url(parsed_url)
					end
				end
			end, { desc = "GitPortal: open link in clipboard" })
		end,
	},

	-- lazygit: full lazygit TUI inside a floating window
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	},
}
