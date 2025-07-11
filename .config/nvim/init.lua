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

function GetYamlPath(opts)
	opts = opts or {}
	local ignored_keys = opts.ignored or { "en", "js", "admin_js" }

	local cursor_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line_num, false)

	local path_parts = {}
	local current_indent = nil

	for i = cursor_line_num, 1, -1 do
		local line = lines[i]
		local indent, key = line:match("^(%s*)([%w_]+):")

		if key then
			local indent_level = #indent

			-- If we're on the cursor line, set the base indent
			if current_indent == nil or indent_level < current_indent then
				table.insert(path_parts, 1, key)
				current_indent = indent_level
			end
		end
	end

	-- Remove ignored keys from the start
	while #path_parts > 0 and vim.tbl_contains(ignored_keys, path_parts[1]) do
		table.remove(path_parts, 1)
	end

	local final_path = table.concat(path_parts, ".")

	if final_path == "" then
		vim.notify("No YAML path found", vim.log.levels.WARN)
		return
	end

	vim.fn.setreg("+", final_path)
	vim.api.nvim_echo({ { final_path, "Normal" } }, false, {})
end

vim.keymap.set("n", "<leader>yl", function()
	GetYamlPath({ ignored = { "en", "js", "admin_js" } })
end, { desc = "Copy YAML key path to clipboard" })

function FindYamlKeyPath(path_str, opts)
	opts = opts or {}
	local ignored_keys = opts.ignored or { "en", "js", "admin_js" }

	if not path_str or path_str == "" then
		vim.notify("Please provide a YAML path (dot-separated)", vim.log.levels.ERROR)
		return
	end

	local parts = vim.split(path_str, ".", { plain = true })
	if #parts == 0 then
		vim.notify("Invalid path", vim.log.levels.ERROR)
		return
	end

	-- Add ignored keys at the start for matching if needed
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local stack = {}

	for i, line in ipairs(lines) do
		local indent, key = line:match("^(%s*)([%w_]+):")
		if key then
			local indent_level = #indent

			-- Pop keys with greater indent
			while #stack > 0 and stack[#stack].indent >= indent_level do
				table.remove(stack)
			end

			table.insert(stack, { key = key, indent = indent_level })

			-- Remove ignored keys from stack copy when comparing
			local compare_stack = vim.tbl_map(function(item)
				return item.key
			end, stack)
			while #compare_stack > 0 and vim.tbl_contains(ignored_keys, compare_stack[1]) do
				table.remove(compare_stack, 1)
			end

			-- Check if the stack matches
			local matches = true
			if #compare_stack == #parts then
				for j = 1, #parts do
					if compare_stack[j] ~= parts[j] then
						matches = false
						break
					end
				end

				if matches then
					-- Jump to the line (0-indexed for nvim_win_set_cursor)
					vim.api.nvim_win_set_cursor(0, { i, 0 })
					vim.cmd("normal! zz")
					vim.notify("Found: " .. table.concat(compare_stack, "."), vim.log.levels.INFO)
					return
				end
			end
		end
	end

	vim.notify("Path not found: " .. path_str, vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("FindYml", function(opts)
	FindYamlKeyPath(opts.args, { ignored = { "en", "js", "admin_js" } })
end, {
	nargs = 1,
	desc = "Jump to YAML key path in dot notation",
})

vim.keymap.set("n", "<leader>yf", function()
	-- Open command-line with prefilled text
	vim.api.nvim_feedkeys(":FindYml ", "n", false)
end, { desc = "Prefill :FindYml command to jump to YAML key" })
