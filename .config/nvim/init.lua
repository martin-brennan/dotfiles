require("plugins")
require("plugins_setup")
require("mappings")

-- auto-compile after plugins config is changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost init.lua source <afile>
    autocmd BufWritePost lua/mappings.lua source <afile>
    autocmd BufWritePost lua/plugins_setup.lua source <afile>
  augroup end
]])

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
