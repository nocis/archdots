-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- disable paste mode when insert leave
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})


-- run camke
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = 'CMakeLists.txt',
	callback = function()
		local on_exit = function(obj)
                    -- print(obj.code)
                    -- print(obj.signal)
                    print(obj.stdout)
                    print(obj.stderr)
                end
		vim.fn.system({"bash", "build.sh"}, on_exit)
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	-- pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",

	pattern = "html",
	callback = function()
		vim.lsp.start({
			name = "emmet-language-server-css",
			cmd = { "node_modules/.bin/emmet-language-server", "--stdio" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
			-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
			-- **Note:** only the options listed in the table are supported.
			init_options = {
				---@type table<string, string>
				includeLanguages = {
					html = "css",
				},
				--- @type string[]
				excludeLanguages = {},
				--- @type string[]
				extensionsPath = {},
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
				preferences = {},
				--- @type boolean Defaults to `true`
				showAbbreviationSuggestions = true,
				--- @type "always" | "never" Defaults to `"always"`
				showExpandedAbbreviation = "always",
				--- @type boolean Defaults to `false`
				showSuggestionsAsSnippets = false,
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
				syntaxProfiles = {},
				--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
				variables = {},
			},
		})
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
	callback = function()
		vim.lsp.start({
			name = "emmet-language-server",
			cmd = { "node_modules/.bin/emmet-language-server", "--stdio" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
			-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
			-- **Note:** only the options listed in the table are supported.
			init_options = {
				---@type table<string, string>
				includeLanguages = {},
				--- @type string[]
				excludeLanguages = {},
				--- @type string[]
				extensionsPath = {},
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
				preferences = {},
				--- @type boolean Defaults to `true`
				showAbbreviationSuggestions = true,
				--- @type "always" | "never" Defaults to `"always"`
				showExpandedAbbreviation = "always",
				--- @type boolean Defaults to `false`
				showSuggestionsAsSnippets = false,
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
				syntaxProfiles = {},
				--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
				variables = {},
			},
		})
	end,
})
