local util = require("lspconfig.util")

local M = {}

local have_vue = require("plugins.utils.have").have_vue()

--  ╭──────────────────────────────────────────────────────────╮
--  │                         Settings                         │
--  ╰──────────────────────────────────────────────────────────╯

local function get_typescript_server_path(root_dir)
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	local found_ts = ""
	local global_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end

	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Volar Config                       │
--  ╰──────────────────────────────────────────────────────────╯

local filetypes = have_vue and { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
	or { "vue" }

local root_dir = have_vue and function(...)
						return require("lspconfig.util").root_pattern("package.json")(...)
					end
	or function(...)
						return ""
					end

local init_options = {}

local on_new_config = function(new_config, new_root_dir)
	new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
end

local settings = {
	typescript = {
		preferences = {
			-- "relative" | "non-relative" | "auto" | "shortest"(not sure)
			importModuleSpecifier = "non-relative",
		},
	},
}

local on_attach = function(client)
	-- NOTE: close volar format
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormatting = false
end

M.capabilities = capabilities
M.filetypes = filetypes
M.root_dir = root_dir
M.init_options = init_options
M.on_new_config = on_new_config
M.settings = settings
M.on_attach = on_attach

return M
