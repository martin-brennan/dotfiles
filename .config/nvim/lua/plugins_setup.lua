-- additional plugin setup --
-- +++++++++++++++++++++++ --
require("fzf-lua").setup({
	winopts = { fullscreen = true, title = "Searching...", preview = { horizontal = "right:50%" } },
	btags = { ctags_autogen = true, ctags_file = "~/.ctags" },
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- Web Languages
		"javascript",
		"typescript",
		"html",
		"css",
		"regex",
		"glimmer",
		-- Documentation Languages
		"markdown",
		"markdown_inline",
		"jsdoc",
		-- Configuration Languages
		"toml",
		"jsonc",
		"dockerfile",
		"lua",
		"vim",
		-- Scripting Languages
		"commonlisp",
		"bash",
		"jq",
		-- Systems Languages
		"c",
		"go",
		-- Utility Syntaxes
		"diff",
		"git_rebase",
		"gitcommit",
		"gitignore",
	},
	highlight = {
		enable = true,
	},
	ignore_install = {
		"json", -- jsonc is better
	},
})

vim.g.ale_fixers = {
	javascript = { "prettier", "eslint" },
	css = { "prettier" },
	scss = { "prettier" },
	ruby = { "syntax_tree" },
	handlebars = { "prettier" },
}
vim.g.ale_fix_on_save = 1
vim.g.ale_linters = { javascript = { "eslint" } }
vim.g.ale_virtualtext_cursor = 0

-- +++++++++++++++++++++++ --
-- /additional plugin setup --
