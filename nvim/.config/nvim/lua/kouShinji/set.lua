-- Sets line numbers and relativenumber
vim.opt.nu = true
vim.opt.relativenumber = true

-- Setting tab width = 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set word/line wrap to false
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.opt.cursorline = true -- highlight the current cursor line

-- Setting autoindentation true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Removes the highlight for searched word
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enables 24-bit color in the TUI
vim.opt.termguicolors = true

-- Set's the left column for lsp warning's display
vim.opt.signcolumn = "yes"

-- The swap file and backup file stuff like the . file it creates and shit annoying stuff turning it off
vim.opt.swapfile = false
vim.opt.backup = false
-- undotree directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- gives 4 lines of padding to cursor when scrolling off-page
vim.opt.scrolloff = 4

-- split windows default side
vim.opt.splitright = true -- split vertical to right side
vim.opt.splitbelow = true -- split horizontal to bottom side

vim.opt.colorcolumn = "90" -- column on the right side to remind me of max line length

-- NOTE: clipboard settings for nvim with WSL
vim.g.clipboard = {
	name = "win32yank-wsl",

	copy = {

		["+"] = "win32yank.exe -i --crlf",

		["*"] = "win32yank.exe -i --crlf",
	},

	paste = {

		["+"] = "win32yank.exe -o --lf",

		["*"] = "win32yank.exe -o --lf",
	},

	cache_enabled = 0,
}
