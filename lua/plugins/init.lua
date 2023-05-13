local plugins = {
	{ "nvim-lua/plenary.nvim" },
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
			})
		end,
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.1" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
		end,
		dependencies = {
			-- formatting , linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("plugins.configs.null_ls")
				end,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- cmp sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",

			-- snippets
			--list of default snippets
			"rafamadriz/friendly-snippets",

			-- snippets engine
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},

			-- autopairs , autocompletes ()[] etc
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup()

					--  cmp integration
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					local cmp = require("cmp")
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},

	"onsails/lspkind.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},

	-- statusline
	{
		"echasnovski/mini.statusline",
		config = function()
			require("mini.statusline").setup({ set_vim_settings = false })
		end,
	},

	{
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.configs.bufferline")
		end,
	},

	-- comment plugin
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.which_key")
		end,
	},
}

local opts = {
	install = {
		missing = true,
		colorscheme = { "onedark" },
	},
}

require("lazy").setup(plugins, opts)
