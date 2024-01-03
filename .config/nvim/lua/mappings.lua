-- vim.api.nvim_set_keymap("i", "<C-i>", "<C-i>", { noremap = true, silent = true })

-- leader key as spacebar
vim.g.mapleader = " "

-- save and selection shortcuts
vim.keymap.set("", "SS", ":w<CR>")
vim.keymap.set("n", "sa", "ggVG")

-- fzf bindings
vim.keymap.set("n", "<C-p>", ":Files<cr>")
vim.keymap.set("n", "ff", ":Files<cr>")
vim.keymap.set("n", "<Leader>b", ":Buffers<cr>")
vim.keymap.set("n", "<Leader><Leader>", ":BTags<cr>")

-- i use ? for global project search so remap to reverse-search
vim.keymap.set("n", "~", "?")
vim.keymap.set("n", '"', "?")
vim.keymap.set("n", "<Leader>f", ":Rg<cr>")
vim.keymap.set("n", "?", ":Rg<cr>")

-- search entire project for word under cursor using ripgrep
vim.keymap.set("n", "&", ":Rg <C-R><C-W><cr>", { silent = true })

-- testing
vim.keymap.set("n", "<Leader>s", ":! clear && smarttest.sh %:p<cr>")
vim.keymap.set("n", "<Leader>l", function()
	vim.cmd(":! clear && smarttest.sh " .. vim.fn.expand("%:p") .. ":" .. vim.fn.line("."))
end)

-- nvim conf reload and open
vim.keymap.set("n", "<Leader>lr", function()
	vim.cmd(":luafile /home/mb/.config/nvim/init.lua")
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
	vim.cmd("echo 'Config reloaded!'")
end)

-- snippets
local ls = require("luasnip")
vim.api.nvim_set_keymap(
	"i",
	"<C-;>",
	'<cmd>lua require"luasnip".expand_or_jump()<CR>',
	{ noremap = true, silent = true }
)

-- quick split and switch to new split window
vim.keymap.set("n", "<leader>vs", ":vsplit<cr><ESC>:wincmd l<cr>")
vim.keymap.set("n", "<leader>hs", ":split<cr><ESC>:wincmd j<cr>")
vim.keymap.set("n", "<leader>w", ":wincmd w<cr>")

-- F9 to format file with the appropeiate tool based on filetype
vim.keymap.set("n", "<F9>", ":Autoformat<CR>")
local formatting_group = vim.api.nvim_create_augroup("formatting", { clear = true })
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "javascript", group = formatting_group, command = "noremap <buffer> <F9> :ALEFix<cr>" }
)
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "lua",
	group = formatting_group,
	command = 'noremap <buffer> <F9> <cmd>lua require("stylua-nvim").format_file()<CR>',
})
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "scss", group = formatting_group, command = "noremap <buffer> <F9> :ALEFix<cr>" }
)
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "ruby", group = formatting_group, command = "noremap <buffer> <F9> :ALEFix<cr>" }
)
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "go", group = formatting_group, command = "noremap <buffer> <F9> :GoFmr<cr>:GoImports<cr>" }
)
vim.api.nvim_create_autocmd(
	{ "FileType" },
	{ pattern = "html.handlebars", group = formatting_group, command = "noremap <buffer> <F9> :ALEFix<cr>" }
)
