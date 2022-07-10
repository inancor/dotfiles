vim.opt.termguicolors = true
vim.cmd([[ colorscheme gruvbox-material ]])
--vim.cmd([[ colorscheme base16-onedark ]])
vim.cmd([[ highlight clear SignColumn ]])
vim.cmd([[ highlight EndOfBuffer guifg=bg ]])
vim.cmd([[ highlight NvimTreeWinSeparator guifg=bg ]])
vim.cmd([[ highlight NvimTreeStatusLine guibg=bg ]])

-- TextEdit might fail if hidden is not set.
vim.opt.hidden = true

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
vim.cmd([[ set shortmess+=c ]])

-- Set tabstop size
local tabsize = 2
vim.opt.tabstop = tabsize
vim.opt.shiftwidth = tabsize

-- Highlight yanked text for 250ms
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch"),
			timeout = 250,
		})
	end,
})

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

--Decrease update time
vim.opt.updatetime = 500
vim.opt.timeoutlen = 500

-- Yank to/from the system clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Use more natural splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show signs in the numbers column, and show the numbers column by default
vim.opt.signcolumn = 'number'
vim.opt.number = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
