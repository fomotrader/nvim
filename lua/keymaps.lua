local map = vim.keymap.set

-- General
map("i", "kj", "<ESC>", {})
map("n", "<C-s>", "<cmd> w <CR>", {})
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- map("n", "n", "nzzzv")
-- map("n", "N", "Nzzzv")

--
-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- nvimtree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
map("n", "<C-h>", "<cmd> NvimTreeFocus <CR>")

-- Telescope
map("n", "<leader>ff", "<cmd> Telescope find_files<CR>", {})
map("n", "<leader>fo", "<cmd> Telescope oldfiles<CR>", {})
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", {})

--vim.keymap.set("n", "<C-s>", function ()
--    print "Hello World"
--end, {})

--Bufferline
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end)
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
