-- Language-specific tools: color value preview (glaze) and Cargo.toml crate management
return {

	-- glaze: inline color preview for hex/rgb/hsl values
	{
		"taigrr/glaze.nvim",
		config = function()
			require("glaze").setup()
		end,
	},

	-- crates.nvim: Cargo.toml crate version info and management
	{
		'saecki/crates.nvim',
		tag = 'stable',
		config = function()
			require('crates').setup()
		end,
	},
}
