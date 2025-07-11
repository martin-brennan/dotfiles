return {
	-- file operations (Delete, Rename etc.)
	"tpope/vim-eunuch",

	-- used by git blame functionality
	"rhysd/git-messenger.vim",

	-- rails tooling
	"tpope/vim-rails",

	-- git tooling
	"tpope/vim-fugitive",

	-- allows fugitive to browse with github
	"tpope/vim-rhubarb",

	-- emmet HTML expansion
	"mattn/emmet-vim",

	-- word motions for moving through camel case and underscores
	"vim-scripts/camelcasemotion",

	-- allows easy block commenting
	"tpope/vim-commentary",

	-- allows surrounding with quotes and toggling quotes
	"tpope/vim-surround",

	-- allows repeating surrounds
	"tpope/vim-repeat",

	-- fancy status bar
	-- "itchyny/lightline.vim",
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- js formatting and snippets
	"pangloss/vim-javascript",

	-- js <template> syntax
	"Quramy/vim-js-pretty-template",

	-- color theme
	"ellisonleao/gruvbox.nvim",

	-- allows calling Autoformat which hooks into e.g. rubocop
	"Chiel92/vim-autoformat",

	-- needed for vim-ruby-block-helpers
	"kana/vim-textobj-user",

	-- shows diffs in gutter
	"mhinz/vim-signify",

	-- navigation for ruby blocks e.g. start/end/parent, works with V
	"dewyze/vim-ruby-block-helpers",

	-- ember syntax
	"joukevandermaas/vim-ember-hbs",

	-- generates tags for jumping to de.setupions in source
	"vim-scripts/taglist.vim",

	-- shows yaml structure in status bar
	"Einenlum/yaml-revealer",

	-- autoformatter
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettier" },
					["javascript.glimmer"] = { "prettier", stop_after_first = true },
					css = { "prettier", "stylelint" },
					scss = { "prettier", "stylelint" },
					ruby = { "syntax_tree" },
					lua = { "stylua" },
					handlebars = { "prettier" },
					cpp = { "clang-format-mp-15" },
					c = { "clang-format-mp-15" },
				},
				format_on_save = {
					-- syntax_tree can take ~500ms! so we need to set this to something higher
					-- timeout_ms = 1000,
					-- lsp_fallback = true,
					lsp_format = "fallback",
					timeout_ms = 1000,
				},
				notify_on_error = false,
				formatters = {
					prettierd = {
						require_cwd = true,
					},
					prettier = {
						require_cwd = true,
					},
					syntax_tree = {
						inherit = false,
						command = "stree",
						args = { "format" },
						require_cwd = false,
						stdin = true,
					},
				},
			})
		end,
	},

	-- find and replace multiple variants of a word (Subvert)
	-- e.g. Address/address/addresses replace with Location/location/locations
	"tpope/vim-abolish",

	-- puppet file syntax
	"rodjek/vim-puppet",

	-- rubocop issues in the editor
	"ngmy/vim-rubocop",

	-- terraform file syntax
	"hashivim/vim-terraform",

	-- golang tooling for vim
	"fatih/vim-go",

	-- js auto import variable
	"kristijanhusak/vim-js-file-import",

	-- replace word under cursor
	"chiedo/vim-dr-replace",

	-- github copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					auto_refresh = true,
				},
				suggestion = {
					auto_trigger = true,
					debounce = 50,
					keymap = {
						accept = "<Tab>",
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = false,
					gitcommit = true,
					gitrebase = true,
				},
			})
		end,
	},

	-- fzf
	{
		"ibhagwan/fzf-lua",
		config = function()
			-- For some reason I had to do this (which is what FzfLua setup_fzfvim_cmds does
			-- internally), because no matter what I did I got "FzfLua is not an editor command"
			-- errors...
			loadstring("return require'fzf-lua.profiles.fzf-vim'.fn_load")()()
			-- vim.cmd("FzfLua setup_fzfvim_cmds")
		end,
	},

	-- lua autoformatter
	"ckipp01/stylua-nvim",

	-- treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},

	-- code snippets, also integrates with autocomplete cmp-nvim
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*",
		-- install jsregexp (optional!:).
		build = "make install_jsregexp",
		config = function()
			require("luasnip").log.set_loglevel("debug")
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
		end,
	},

	-- manager for lsps, linters, and formatter
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	-- floating terminal overlay for spec runs etc
	"voldikss/vim-floaterm",

	-- LSP and autocomplete plugins
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	{ "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" } },
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",

	-- colour scheme kanagawa
	"rebelot/kanagawa.nvim",

	-- preview code de.setupions
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},

	spec = {
		-- import your plugins
		{ import = "plugins" },
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "kanagawa-wave" } },
	-- automatically check for plugin updates
	checker = { enabled = true },

	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
			})
		end,
	},

	{ "nvim-tree/nvim-web-devicons", opts = {} },
}
