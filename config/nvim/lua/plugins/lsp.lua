return {
	-- tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"typescript-language-server",
				"css-lsp",
			})
		end,
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
			setup = {
				tsserver = function()
                                    require("lazyvim.util").lsp.on_attach(function(client, bufnr)
							local make_diagnostics_handler = function(original_handler)
							    return function(...)
							        local config_or_client_id = select(4, ...)
   							        local is_new = type(config_or_client_id) ~= "number"
  							        local result = is_new and select(2, ...) or select(3, ...)

							        local filter_out_diagnostics_by_severity = {}
							        local filter_out_diagnostics_by_code = { 80001 }

							        -- Convert string severities to numbers
							        filter_out_diagnostics_by_severity = vim.tbl_map(function(severity)
							            if type(severity) == "string" then
							                return u.severities[severity]
							            end

							            return severity
							        end, filter_out_diagnostics_by_severity)

							        if #filter_out_diagnostics_by_severity > 0 or #filter_out_diagnostics_by_code > 0 then
							            local filtered_diagnostics = vim.tbl_filter(function(diagnostic)
 							               -- Only filter out Typescript LS diagnostics
  							              if diagnostic.source ~= "typescript" then
  							                  return true
   							             end

							                -- Filter out diagnostics with forbidden severity
							                if vim.tbl_contains(filter_out_diagnostics_by_severity, diagnostic.severity) then
							                    return false
							                end

							                -- Filter out diagnostics with forbidden code
							                if vim.tbl_contains(filter_out_diagnostics_by_code, diagnostic.code) then
							                    return false
							                end

							                return true
							            end, result.diagnostics)

							            result.diagnostics = filtered_diagnostics
							        end

							        local config_idx = is_new and 4 or 6
							        local config = select(config_idx, ...) or {}

							        if is_new then
							            original_handler(select(1, ...), select(2, ...), select(3, ...), config)
							        else
							            original_handler(select(1, ...), select(2, ...), select(3, ...), select(4, ...), select(5, ...), config)
							        end
							    end
							end
							
							local PUBLISH_DIAGNOSTICS = "textDocument/publishDiagnostics"
						        local diagnostics_handler = client.handlers[PUBLISH_DIAGNOSTICS] or vim.lsp.handlers[PUBLISH_DIAGNOSTICS]
							
							client.handlers[PUBLISH_DIAGNOSTICS] = make_diagnostics_handler(diagnostics_handler)
                                        end)
                               end,
			},
		},
	},
}
