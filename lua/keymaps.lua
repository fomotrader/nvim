local map = vim.keymap.set

-- General
map("i", "kj", "<ESC>", {})
map("n", "<C-s>", "<cmd> w <CR>", {})

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
