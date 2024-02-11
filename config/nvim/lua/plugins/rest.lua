return{
-- plugins/rest.lua
 {
   "rest-nvim/rest.nvim",
   dependencies = { { "nvim-lua/plenary.nvim" } },
   config = function()
     require("rest-nvim").setup({
        -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = true,
      -- stay in current windows (.http file) or change to results window (default)
      stay_in_current_window_after_split = true,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        -- show the generated curl command in case you want to launch
        -- the same request via the terminal (can be verbose)
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        -- table of curl `--write-out` variables or false if disabled
        -- for more granular control see Statistics Spec
        show_statistics = false,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = true,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
      search_back = true,
    })

   -- http
    vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    callback = function ()
        local buff = tonumber(vim.fn.expand("<abuf>"), 10)
        vim.keymap.set("n", "<leader>rn", "<Plug>RestNvim<CR>", { noremap = true, buffer = buff, desc = "RestNvim" })
        vim.keymap.set("n", "<leader>rl", "<Plug>RestNvimLast<CR>", { noremap = true, buffer = buff, desc = "RestNvimLast" })
        vim.keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview<CR>", { noremap = true, buffer = buff, desc = "RestNvimWithPreview" })
	require("which-key").register({
		["r"] = {
			name = "+rest",
		},
	}, { prefix = "<leader>" })
    end
    })
			
  end
},
}
