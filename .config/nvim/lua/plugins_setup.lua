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

vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "html.handlebars", command = "let b:ale_javascript_prettier_options = '--parser=glimmer'" }
)
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "javascript.glimmer", command = "let b:ale_javascript_prettier_options = '--parser=glimmer'" }
)

vim.g.git_messenger_close_on_cursor_moved = false
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_include_diff = "current"
vim.g.git_messenger_preview_mods = "botright"
vim.g.git_messenger_extra_blame_args = "--ignore-revs-file=.git-blame-ignore-revs"

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- https://github.com/zbirenbaum/copilot.lua/issues/91#issuecomment-1345190310
		["<Tab>"] = cmp.mapping(function(fallback)
			luasnip = require("luasnip")
			if require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup language servers.
local lspconfig = require("lspconfig")
-- lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.ember.setup({ capabilities = capabilities })
lspconfig.solargraph.setup({ capabilities = capabilities })

-- set up indentation guides
require("ibl").setup()

-- +++++++++++++++++++++++ --
-- /additional plugin setup --
