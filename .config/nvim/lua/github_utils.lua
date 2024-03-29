function trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function GithubLink(opts, optionalSha)
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))
	local originRepo = vim.fn.system("cd " .. dir .. " && git config --get remote.origin.url")
	local repoN = vim.fn.substitute(vim.fn.split(originRepo, ":")[2], ".git", "", "")

	local repo = repoN:gsub("[\r\n]", "")
	local root = trim(vim.fn.system("cd " .. dir .. "  && git rev-parse --show-toplevel"))
	local relative = string.sub(path, string.len(root) + 1, string.len(path))

	local repoShaN = vim.fn.system("cd " .. dir .. " && git rev-parse HEAD")
	local repoSha
	if optionalSha == "main" or optionalSha == "mainfile" then
		repoSha = "main"
	else
		repoSha = repoShaN:gsub("[\r\n]", "")
	end

	local link = "https://github.com/" .. repo .. "/blob/" .. repoSha .. relative
	if optionalSha ~= "file" and optionalSha ~= "mainfile" then
		link = link .. "#L" .. opts.line1 .. "-L" .. opts.line2
	end

	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	vim.notify(link)
end

function GithubLinkFile(opts, optionalSha)
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))
	local originRepo = vim.fn.system("cd " .. dir .. " && git config --get remote.origin.url")
	local repoN = vim.fn.substitute(vim.fn.split(originRepo, ":")[2], ".git", "", "")

	local repo = repoN:gsub("[\r\n]", "")
	local root = trim(vim.fn.system("cd " .. dir .. "  && git rev-parse --show-toplevel"))
	local relative = string.sub(path, string.len(root) + 1, string.len(path))

	local repoShaN = vim.fn.system("cd " .. dir .. " && git rev-parse HEAD")
	local repoSha
	if optionalSha == "main" or optionalSha == "mainfile" then
		repoSha = "main"
	else
		repoSha = repoShaN:gsub("[\r\n]", "")
	end

	local link = "https://github.com/" .. repo .. "/blob/" .. repoSha .. relative

	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	vim.notify(link)
end

function CommitLink(opts)
	local sha = vim.fn.getreg('"')
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))
	local originRepo = vim.fn.system("cd " .. dir .. " && git config --get remote.origin.url")
	local repoN = vim.fn.substitute(vim.fn.split(originRepo, ":")[2], ".git", "", "")
	local repo = repoN:gsub("[\r\n]", "")
	local link = "https://github.com/" .. repo .. "/commit/" .. sha

	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	vim.notify(link)
end

function GithubBlameLine(opts)
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))
	local originRepo = vim.fn.system("cd " .. dir .. " && git config --get remote.origin.url")
	local repoN = vim.fn.substitute(vim.fn.split(originRepo, ":")[2], ".git", "", "")
	local repo = repoN:gsub("[\r\n]", "")
	local root = vim.fn.system("cd " .. dir .. " && git rev-parse --show-toplevel")
	local relative = string.sub(path, string.len(root), -1)

	local link = "https://github.com/" .. repo .. "/blame/main" .. relative
	link = link .. "#L" .. opts.line1 .. "-L" .. opts.line2

	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	vim.notify(link)
end

function GithubHistory(opts)
	local path = vim.fn.resolve(vim.fn.expand("%:p"))
	local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ":h"))
	local originRepo = vim.fn.system("cd " .. dir .. " && git config --get remote.origin.url")
	local repoN = vim.fn.substitute(vim.fn.split(originRepo, ":")[2], ".git", "", "")
	local repo = repoN:gsub("[\r\n]", "")
	local root = vim.fn.system("cd " .. dir .. " && git rev-parse --show-toplevel")
	local relative = string.sub(path, string.len(root), -1)

	local link = "https://github.com/" .. repo .. "/commits/main" .. relative

	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	vim.notify(link)
end
