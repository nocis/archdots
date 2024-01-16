local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
-- n: normal mode
keymap.set("n", "<kPlus>", "<C-a>")
keymap.set("n", "<kMinus>", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
-- keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
-- keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
-- keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)
-- Move window
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")


keymap.set("n", "<leader>r", function()
	require("lib.craftzdog.hsl").replaceHexWithHSL()
end)

-- unstable pre release
-- keymap.set("n", "<leader>i", function()
-- 	require("lib.craftzdog.lsp").toggleInlayHints()
-- end)
