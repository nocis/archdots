return {
	-- Create annotations with one keybind, and jump your cursor in the inserted annotation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- Go forward/backward with square brackets
	{
		'echasnovski/mini.bracketed', 
    version = '*',
		opts = {
	buffer     = { suffix = 'b', options = {} },
        comment    = { suffix = '/', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        file       = { suffix = '' },
        indent     = { suffix = 'i', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'l', options = {} },
        oldfile    = { suffix = '' },
        quickfix   = { suffix = '' },
        treesitter = { suffix = 'n', options = {} },
        undo       = { suffix = '' },
        window     = { suffix = '' },
        yank       = { suffix = '' },
    },
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	-- colorize
	{
	    'norcalli/nvim-colorizer.lua', 
	     event = 'VeryLazy',
             opts = {
                 filetypes = { '*', '!lazy'，css = {css = true} }
             }
	},
}
