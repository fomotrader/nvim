local new_cmd = vim.api.nvim_create_user_command

local ls = {
	"gopls",
	"lua-language-server",
	"typescript-language-server",
	"stylelua",
}

new_cmd("MassonInstallAll", function()
	vim.cmd("MasonInstall " .. table.concat(ls, " "))
end, {})
