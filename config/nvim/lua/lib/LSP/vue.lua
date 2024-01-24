local util = require("lspconfig.util")
local have_vue = require("lib.utils.have").have_vue()
local M = {}
local root_dir = function(...)
	return require("lspconfig.util").root_pattern("package.json")(...)
end

M.root_dir = root_dir
return M
