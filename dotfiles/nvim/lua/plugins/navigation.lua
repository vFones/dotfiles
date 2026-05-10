-- Navigation aids: cursor motion hints and animated cursor movement
return {

	-- precognition: motion hints overlay (w, b, e, ^, $ etc.)
	{
		"tris203/precognition.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>p", "<CMD>Precognition toggle<CR>", desc = "Precognition: toggle" },
		},
		opts = {
			startVisible = false,
		},
	},

	-- smear-cursor: animated smear effect when the cursor moves
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			never_draw_over_target = true,
		},
	},
}
