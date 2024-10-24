return {
	{
		"rasulomaroff/cursor.nvim",
		event = "VeryLazy",
		opts = {
			overwrite_cursor = true,
			cursors = {
				{
					mode = "v",
					shape = "ver",
					blink = false,
                    size = 10
				},
				{
					mode = "n",
					shape = "block",
					blink = false,
                    size = 100
				},
				{
					mode = "i",
					shape = "ver",
					blink = false,
                    size = 10
				},
			},
		},
	},
}
