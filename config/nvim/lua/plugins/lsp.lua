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
				"vue-language-server",
				"css-lsp",
			})
		end,
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			--@type lspconfig.options
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				volar = {
					-- capabilities = require("plugins.LSP.vue").capabilities,
					filetypes = require("customLib.LSP.vue").filetypes,
					root_dir = require("customLib.LSP.vue").root_dir,
					-- init_options = require("plugins.LSP.vue").init_options,
					on_new_config = require("customLib.LSP.vue").on_new_config,
					settings = require("customLib.LSP.vue").settings,
					on_attach = require("customLib.LSP.vue").on_attach,
				},
				tsserver = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					root_dir = function(...)
						local useTypeServer = require("customLib.utils.have").enabled_typescript_tools()
						if useTypeServer then
							return require("lspconfig.util").root_pattern(".git")(...)
						else
							return ""
						end
					end,
					single_file_support = false,
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
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
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
						{
							"<leader>cR",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.removeUnused.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Remove Unused Imports",
						},
						{
							"<leader>ci",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.addMissingImports.ts" },
										diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf()),
									},
								})
							end,
							desc = "Add Missing Imports",
						},
						{
							"<leader>cs",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.sortImports.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Sort Imports",
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
				volar = function()
					require("lazyvim.util").lsp.on_attach(function(client)
						-- Don't use volar for formatting
						if client.name == "volar" then
							client.server_capabilities.documentFormatting = false
							-- client.server_capabilities.documentFeatures.documentFormatting = false
							client.server_capabilities.documentFormattingProvider = false
						end
					end)
				end,
				tsserver = function()
					require("lazyvim.util").lsp.on_attach(function(client, bufnr)
						if vim.fn.has("nvim-0.8") == 1 then
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						else
							client.resolved_capabilities.document_formatting = false
							client.resolved_capabilities.document_range_formatting = false
						end
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
										return require("nvim-lsp-ts-utils.utils").severities[severity]
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
										if
											vim.tbl_contains(filter_out_diagnostics_by_severity, diagnostic.severity)
										then
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
									original_handler(
										select(1, ...),
										select(2, ...),
										select(3, ...),
										select(4, ...),
										select(5, ...),
										config
									)
								end
							end
						end

						local PUBLISH_DIAGNOSTICS = "textDocument/publishDiagnostics"
						local diagnostics_handler = client.handlers[PUBLISH_DIAGNOSTICS]
							or vim.lsp.handlers[PUBLISH_DIAGNOSTICS]

						client.handlers[PUBLISH_DIAGNOSTICS] = make_diagnostics_handler(diagnostics_handler)
					end)
				end,
			},
		},
	},
}
