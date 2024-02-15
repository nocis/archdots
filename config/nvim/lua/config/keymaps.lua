local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
-- n: normal mode
keymap.set("n", "<kPlus>", function()
    require("dial.map").manipulate("increment", "normal")
end)
keymap.set("n", "<kMinus>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
-- keymap.set("n", "<kPlus>", "<C-a>")
-- keymap.set("n", "<kMinus>", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')

-- Disable continuations
-- keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
-- keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
-- keymap.set("n", "<C-m>", "<C-i>", opts)
   vim.keymap.set('n', '<leader>j', function()
     require('whatthejump').browse_jumps()
   end, { desc = 'show jumps'})

-- New tab
-- keymap.set("n", "te", ":tabedit")
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)
-- Move window
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")

-- keymap.set("n", "<leader>r", function()
--	require("customLib.craftzdog.hsl").replaceHexWithHSL()
-- end)

-- unstable pre release
-- keymap.set("n", "<leader>i", function()
-- 	require("customLib.craftzdog.lsp").toggleInlayHints()
-- end)

-- Diagnostics
vim.keymap.set("n", "<leader>i", function()
	-- If we find a floating window, close it.
	local found_float = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
			found_float = true
		end
	end

	if found_float then
		return
	end

	vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Toggle Diagnostics" })

-- nabla
keymap.set("n", "<leader>p", function()
	require("nabla").popup()
end, {
	desc = "nabla popup",
})


-- git
keymap.set("n", "<leader>gb", function()
	require("gitsigns.actions").toggle_current_line_blame()
end, {
	desc = "toggle git blame",
})
keymap.set("n", "<leader>gp", function()
	require("gitsigns.actions").preview_hunk()
end, {
	desc = "Preview Hunk",
})
keymap.set("n", "<leader>gP", function()
	require("gitsigns.actions").preview_hunk_inline()
end, {
	desc = "Preview Hunk Inline",
})

