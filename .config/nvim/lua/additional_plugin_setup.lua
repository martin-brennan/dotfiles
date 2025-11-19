-- additional plugin setup --
-- +++++++++++++++++++++++ --
-- local ccumec_cmp_source = require("ccumec_cmp_source")

require("fzf-lua").setup({
	file_icons = true,
	winopts = {
		fullscreen = true,
		title = "Searching...",
		preview = { horizontal = "right:50%", layout = "horizontal" },
	},
	btags = { ctags_autogen = true, ctags_file = "~/.ctags" },
})

require("fzf-lua").register_ui_select()

-- -- May need to reinstall these sometimes after updates with TSInstall!
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- Web Languages
		"javascript",
		"typescript",
		"html",
		"css",
		"regex",
		"glimmer",
		"glimmer_javascript",
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

vim.g.git_messenger_close_on_cursor_moved = false
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_include_diff = "current"
vim.g.git_messenger_preview_mods = "botright"
-- vim.g.git_messenger_extra_blame_args = "--ignore-revs-file=.git-blame-ignore-revs"

-- Set up nvim-cmp for autocompletion.
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
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
		-- { name = "nvim_lsp" },
		-- { name = "ccumec_cmp_source" },
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
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "ccumec_cmp" },
	}, {
		{ name = "buffer" },
	}),
})

require("cmp_git").setup()

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

require("mason").setup()

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup language servers.
vim.lsp.config("yamlls", { capabilities = capabilities })
vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.config("ember", { capabilities = capabilities })
vim.lsp.config("ruby_lsp", {
	capabilities = capabilities,
	init_options = {
		formatter = "standard",
		linters = { "standard" },
		indexing = {
			excludedPatterns = {
				"spec/**/*",
				"plugins/spec/**/*",
			},
		},
	},
  settings = {
    rubyLspRails = {
      enablePendingMigrationsPrompt = false,
    },
  },
})
vim.lsp.config("rubocop", { capabilities = capabilities })
vim.lsp.config("syntax_tree", { capabilities = capabilities })
vim.lsp.config("stylelint_lsp", { capabilities = capabilities })
vim.lsp.config("gopls", { capabilities = capabilities })
local base_eslint_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"typescript",
		"typescript.glimmer",
		"javascript.glimmer",
		"json",
		"markdown",
	},
	on_attach = function(client, bufnr)
		if not base_eslint_on_attach then
			return
		end

		base_eslint_on_attach(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "LspEslintFixAll",
		})
	end,
})

for _, server in ipairs({
	"yamlls",
	"clangd",
	"ember",
	"ruby_lsp",
	"rubocop",
	"syntax_tree",
	"stylelint_lsp",
	"gopls",
	"eslint",
}) do
	vim.lsp.enable(server)
end

-- set up indentation guides
local highlight = {
	"CursorColumn",
	"Whitespace",
}
-- require("ibl").setup({ scope = { enabled = false } })

-- Set Lightline configuration in Lua for Neovim
-- vim.g.lightline = {
-- 	active = {
-- 		left = { { "mode", "paste" }, { "readonly", "relativepath", "modified" } },
-- 	},
-- 	inactive = {
-- 		left = { { "mode", "paste" }, { "readonly", "relativepath", "modified" } },
-- 	},
-- }

-- Convert dot-separated keys to '>'-separated keys and call SearchYamlKey
function SearchYamlKeyDotSeparated(key)
	-- Replace '.' with '>'
	local formatted_key = key:gsub("%.", ">")
	-- Escape single quotes for safe Vimscript passing
	local escaped_key = formatted_key:gsub("'", "''")
	-- Call the Vimscript SearchYamlKey function safely
	vim.cmd(string.format("call SearchYamlKey('%s')", escaped_key))
end

require("lualine").setup({
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
	inactive_sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
})

-- +++++++++++++++++++++++ --
-- /additional plugin setup --
