require("lazy_setup")
require("additional_plugin_setup")
require("mappings")

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

-- do not mess with line endings
vim.opt.fixeol = false

-- makes it so when copying using yy etc we copy to the system clipboard as well
vim.opt.clipboard = "unnamedplus"

-- set colour schme
vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_transparent_bg = 1

-- temporary workdown to stop flickering
vim.g._ts_force_sync_parsing = true

-- terminal
vim.opt.colorcolumn = "120"

-- go away annoying swapfiles
vim.opt.swapfile = false

-- no need to show mode because lightline shows it
vim.opt.showmode = false

-- scroll cursor with mousewheel and set offset
vim.opt.scrolloff = 5
vim.keymap.set("", "<ScrollWheelUp>", "k")
vim.keymap.set("", "<ScrollWheelDown>", "j")

-- turn off mouse mode so i can select text with it & copy
vim.opt.mouse = ""

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

-- highlighting colours for search
vim.cmd([[
  hi IncSearch guifg=#fabd2f guibg=#3c3836
  hi Search cterm=undercurl gui=undercurl guisp=#8ec07c
]])

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	end,
})

vim.opt.regexpengine = 0
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Add an autocmd for text and markdown files
vim.api.nvim_create_augroup("SpellCheck", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "SpellCheck",
	pattern = { "txt", "markdown" }, -- Match filetypes
	callback = function()
		vim.opt_local.spell = true -- Enable spell checking
		vim.opt_local.spelllang = "en" -- Set the spell check language to English
	end,
})

-- auto comments
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:append("cro")
	end,
})
