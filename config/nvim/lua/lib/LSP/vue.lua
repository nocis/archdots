local util = require("lspconfig.util")
local have_vue = require("lib.utils.have").have_vue()
local M = {}
local root_dir = have_vue and function(...)
						return require("lspconfig.util").root_pattern("package.json")(...)
					end
	or function(...)
						return ""
					end
M.root_dir = root_dir
return M
