-- Mapping with lua:
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

require("github_utils")

-- leader key as spacebar
vim.g.mapleader = " "

-- save and selection shortcuts
vim.keymap.set("", "SS", ":w<CR>")
vim.keymap.set("n", "<leader>sa", "ggVG")

-- fzf bindings
vim.keymap.set("n", "<C-p>", ":Files<cr>")
vim.keymap.set("n", "ff", ":Files<cr>")
vim.keymap.set("n", "<Leader>b", ":Buffers<cr>")
vim.keymap.set("n", "<Leader><Leader>", ":BTags<cr>")
vim.keymap.set("n", "<Esc><Esc>", ":noh<cr>")

-- i use ? for global project search so remap to reverse-search
vim.keymap.set("n", "~", "?")
vim.keymap.set("n", '"', "?")
vim.keymap.set("n", "?", ":Rg<cr>")

-- spawn a basic floating terminal in current dir
vim.keymap.set("n", "<Leader>ft", ":FloatermNew! --height=0.85 --width=0.85 --title=~Terminal~<cr>")

-- search entire project for word under cursor using ripgrep
vim.keymap.set("n", "&", ":Rg <C-R><C-W><cr>", { silent = true })

-- navigate quickfix list
vim.keymap.set("n", "<leader>cn", ":cn<cr>")
vim.keymap.set("n", "<leader>cp", ":cp<cr>")

-- toggle copilot
vim.keymap.set("n", "<leader>ai", ":Copilot toggle<cr>")

-- go into normal mode from terminal popover window
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- running rspec tests in floating terminal
vim.keymap.set("n", "<Leader>s", function()
	vim.cmd(":FloatermNew --height=0.9 --width=0.9 --title=Running\\ specs... --autoclose=0 smarttest.sh %:p")
end)
vim.keymap.set("n", "<Leader>l", function()
	vim.cmd(
		":FloatermNew --height=0.9 --width=0.9 --title=Running\\ specs... --autoclose=0 smarttest.sh "
			.. vim.fn.expand("%:p")
			.. ":"
			.. vim.fn.line(".")
	)
end)

vim.keymap.set("n", "<Leader>cc", function()
	vim.cmd(":FloatermNew --height=0.9 --width=0.9 --title=MyCommits --autoclose=0 ccumec")
end)

-- copy system spec command to clipboard
function SystemSpecRun(opts)
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))

	local cmd = "sysspecrun " .. path .. ":" .. opts.line1
	vim.fn.setreg("+", cmd)
	vim.fn.setreg("*", cmd)

	vim.notify(cmd)
end
vim.api.nvim_create_user_command("SystemSpecRun", function(opts)
	SystemSpecRun(opts)
end, { nargs = "*", range = true })
vim.keymap.set("n", "<leader>ys", ":SystemSpecRun<cr>")
vim.keymap.set("v", "<leader>ys", ":SystemSpecRun<cr>")

-- nvim conf reload and open
-- vim.keymap.set("n", "<Leader>lr", function()
-- 	vim.cmd(":luafile ~/.config/nvim/lua/plugins_setup.lua")
-- 	vim.cmd(":luafile ~/.config/nvim/lua/mappings.lua")
-- 	vim.cmd(":luafile ~/.config/nvim/init.lua")
-- 	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
-- 	vim.cmd("echo 'Config reloaded!'")
-- end)

-- git bindings
vim.api.nvim_create_user_command("GithubLink", function(opts)
	GithubLink(opts, "auto")
end, { nargs = "*", range = true })
vim.api.nvim_create_user_command("GithubLinkFile", function(opts)
	GithubLinkFile(opts, "auto")
end, { nargs = "*", range = true })
vim.api.nvim_create_user_command("CommitLink", function(opts)
	CommitLink(opts)
end, { nargs = "*", range = true })
vim.api.nvim_create_user_command("GithubBlameLine", function(opts)
	GithubBlameLine(opts)
end, { nargs = "*", range = true })
vim.api.nvim_create_user_command("GithubHistory", function(opts)
	GithubHistory(opts)
end, { nargs = "*", range = true })

vim.keymap.set("v", "<leader>gh", ":GithubLink<cr>")
vim.keymap.set("n", "<leader>gg", ":GFiles?<cr>")
vim.keymap.set("n", "<leader>gj", "<plug>(signify-next-hunk)")
vim.keymap.set("n", "<leader>gk", "<plug>(signify-prev-hunk)")
vim.keymap.set("n", "<leader>gcl", ":g/Commit:<cr><cr>wwwviwy:CommitLink<cr>")
vim.keymap.set("v", "<leader>gbl", ":GithubBlameLine<cr>")

-- snippets
local ls = require("luasnip")
vim.api.nvim_set_keymap(
	"i",
	"<C-;>",
	'<cmd>lua require"luasnip".expand_or_jump()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"i",
	"<C-i>",
	'<cmd>lua require"luasnip".expand_or_jump()<CR>',
	{ noremap = true, silent = true }
)

-- re-select after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quick split and switch to new split window
vim.keymap.set("n", "<leader>vs", ":vsplit<cr><ESC>:wincmd l<cr>")
vim.keymap.set("n", "<leader>hs", ":split<cr><ESC>:wincmd j<cr>")
vim.keymap.set("n", "<leader>w", ":wincmd w<cr>")

-- get nvim diagnostics from lsp into quickfix list
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- open diagnostics in floating window so you can see the full message
vim.keymap.set("n", "<space>?", vim.diagnostic.open_float, bufopts)

-- Map the key sequence <leader>sy to search for YAML keys using the dot-separated format
vim.api.nvim_set_keymap(
	"n",
	"<leader>sy",
	':lua SearchYamlKeyDotSeparated(vim.fn.input("YAML Key: "))<CR>',
	{ noremap = true, silent = true }
)
