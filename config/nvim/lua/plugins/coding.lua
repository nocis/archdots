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
		"echasnovski/mini.bracketed",
		version = "*",
		opts = {
			buffer = { suffix = "b", options = {} },
			comment = { suffix = "/", options = {} },
			conflict = { suffix = "x", options = {} },
			diagnostic = { suffix = "d", options = {} },
			file = { suffix = "" },
			indent = { suffix = "i", options = {} },
			jump = { suffix = "j", options = {} },
			location = { suffix = "l", options = {} },
			oldfile = { suffix = "" },
			quickfix = { suffix = "" },
			treesitter = { suffix = "n", options = {} },
			undo = { suffix = "" },
			window = { suffix = "" },
			yank = { suffix = "" },
		},
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      -- { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      -- { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
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
					augend.hexcolor.new({
						case = "lower",
					}),
				},
			})
		end,
	},

	 -- colorize
  {
    "nocis/ccc.nvim",
    event = { "BufReadPost", "InsertEnter", "VeryLazy" },
    config = function()
      vim.opt.termguicolors = true
      local ccc = require("ccc")
      require("ccc").setup({
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        inputs = {
          ccc.input.oklch,
          ccc.input.rgb,
          ccc.input.hsl,
        },
        outputs = {
          ccc.output.css_oklch,
          ccc.output.hex,
          ccc.output.css_rgb,
          ccc.output.css_hsl,
        },
      })
    end,
  },

	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "InsertEnter", "VeryLazy" },
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					"!lazy",
					css = { css = true, rgb_fn = true, hsl_fn = true, RRGGBBAA = true, names = true },
					html = { css = true, rgb_fn = true, hsl_fn = true, RRGGBBAA = true, names = true },
				},
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue or blue
					RRGGBBAA = false, -- #RRGGBBAA hex codes
					AARRGGBB = false, -- 0xAARRGGBB hex codes
					rgb_fn = false, -- CSS rgb() and rgba() functions
					hsl_fn = false, -- CSS hsl() and hsla() functions
					css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = true, -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false,
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end,
	},

	-- math tex
	{
		"jbyuki/nabla.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	 -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "latex",
        "css",
        "http",
        "json",
        "glsl",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>p", group = "Pop up" },
        {
          "<leader>pc",
          vim.cmd.CccPick,
          mode = { "n", "x" },
          desc = "Color Picker",
        },
        {
          "<leader>pn",
          function()
            require("nabla").popup()
          end,
          mode = { "n" },
          desc = "nabla popup",
        },
        {
          "<leader>py",
          function()
            if LazyVim.pick.picker.name == "telescope" then
              require("telescope").extensions.yank_history.yank_history({})
            else
              vim.cmd([[YankyRingHistory]])
            end
          end,
          mode = { "n", "x" },
          desc = "Open Yank History",
        },
      },
    },
  },

}
