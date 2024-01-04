require("plugins")

-- additional plugin setup
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

require("mappings")

-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

-- set tabs/spaces and line numbering
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ttyfast = true
vim.opt.re = 1
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.cursorline = true

-- makes it so when copying using yy etc we copy to the system clipboard as well
vim.opt.clipboard = "unnamedplus"

-- set colour schme
vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_transparent_bg = 1

-- terminal
vim.opt.colorcolumn = "120"

-- go away annoying swapfiles
vim.opt.swapfile = false

-- scroll cursor with mousewheel and set offset
vim.opt.scrolloff = 5
vim.keymap.set("", "<ScrollWheelUp>", "k")
vim.keymap.set("", "<ScrollWheelDown>", "j")

-- list all snippets for current filetype
local list_snips = function()
	local ft_list = require("luasnip").available()[vim.o.filetype]
	local ft_snips = {}
	for _, item in pairs(ft_list) do
		ft_snips[item.trigger] = item.name
	end
	print(vim.inspect(ft_snips))
end
vim.api.nvim_create_user_command("SnipList", list_snips, {})
