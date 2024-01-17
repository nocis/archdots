return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "justinhj/battery.nvim" },
		event = "VeryLazy",

		opts = function(_, opts)
			local colors = require("tokyonight.colors").setup({ transform = true })
			local nvimbatteryn = {
				function()
					return require("battery").get_status_line()
				end,
				color = { fg = colors.black, bg = colors.blue },
			}
			table.insert(opts.sections.lualine_x, nvimbatteryn)
			opts.options.globalstatus = false
		end,
	},
}
