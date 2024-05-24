return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- file operations (Delete, Rename etc.)
	use({ "tpope/vim-eunuch" })

	-- used by git blame functionality
	use({ "rhysd/git-messenger.vim" })

	-- rails tooling
	use({ "tpope/vim-rails" })

	-- git tooling
	use({ "tpope/vim-fugitive" })

	-- allows fugitive to browse with github
	use({ "tpope/vim-rhubarb" })

	-- emmet HTML expansion
	use({ "mattn/emmet-vim" })

	-- word motions for moving through camel case and underscores
	use({ "vim-scripts/camelcasemotion" })

	-- allows easy block commenting
	use({ "tpope/vim-commentary" })

	-- allows surrounding with quotes and toggling quotes
	use({ "tpope/vim-surround" })

	-- allows repeating surrounds
	use({ "tpope/vim-repeat" })

	-- fancy status bar
	use({ "itchyny/lightline.vim" })

	-- js formatting and snippets
	use({ "pangloss/vim-javascript" })

	-- js <template> syntax
	use({ "Quramy/vim-js-pretty-template" })

	-- color theme
	use({ "ellisonleao/gruvbox.nvim" })

	-- allows calling Autoformat which hooks into e.g. rubocop
	use({ "Chiel92/vim-autoformat" })

	-- needed for vim-ruby-block-helpers
	use({ "kana/vim-textobj-user" })

	-- shows diffs in gutter
	use({ "mhinz/vim-signify" })

	-- navigation for ruby blocks e.g. start/end/parent, works with V
	use({ "dewyze/vim-ruby-block-helpers" })

	-- ember syntax
	use({ "joukevandermaas/vim-ember-hbs" })

	-- generates tags for jumping to definitions in source
	use({ "vim-scripts/taglist.vim" })

	-- shows yaml structure in status bar
	use({ "Einenlum/yaml-revealer" })

	-- autoformatter
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettier" } },
					["javascript.glimmer"] = { { "prettierd", "prettier" } },
					css = { { "prettierd", "prettier" } },
					scss = { { "prettierd", "prettier" } },
					ruby = { "syntax_tree" },
					lua = { "stylua" },
					handlebars = { { "prettier" } },
					go = { "gofmt", "goimports" },
				},
				format_on_save = {
					-- syntax_tree can take ~500ms! so we need to set this to something higher
					timeout_ms = 1000,
					lsp_fallback = true,
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
	})

	-- find and replace multiple variants of a word (Subvert)
	-- e.g. Address/address/addresses replace with Location/location/locations
	use({ "tpope/vim-abolish" })

	-- puppet file syntax
	use({ "rodjek/vim-puppet" })

	-- rubocop issues in the editor
	use({ "ngmy/vim-rubocop" })

	-- terraform file syntax
	use({ "hashivim/vim-terraform" })

	-- golang tooling for vim
	use({ "fatih/vim-go" })

	-- js auto import variable
	use({ "kristijanhusak/vim-js-file-import" })

	-- replace word under cursor
	use({ "chiedo/vim-dr-replace" })

	-- github copilot
	use({
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
			})
		end,
	})

	-- fzf
	use({
		"ibhagwan/fzf-lua",
		config = function()
			-- For some reason I had to do this (which is what FzfLua setup_fzfvim_cmds does
			-- internally), because no matter what I did I got "FzfLua is not an editor command"
			-- errors...
			loadstring("return require'fzf-lua.profiles.fzf-vim'.fn_load")()()
			-- vim.cmd("FzfLua setup_fzfvim_cmds")
		end,
	})

	-- lua autoformatter
	use({ "ckipp01/stylua-nvim" })

	-- treesitter for syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- code snippets, also integrates with autocomplete cmp-nvim
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
		config = function()
			require("luasnip").log.set_loglevel("debug")
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
		end,
	})

	-- manager for lsps, linters, and formatter
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- floating terminal overlay for spec runs etc
	use({ "voldikss/vim-floaterm" })

	-- LSP and autocomplete plugins
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip" })

	-- indentation guides
	use({ "lukas-reineke/indent-blankline.nvim" })

	-- colour scheme kanagawa
	use({ "rebelot/kanagawa.nvim" })
end)
