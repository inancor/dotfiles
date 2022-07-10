local null_ls = require 'null-ls'
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

local typescript_actions = require 'patch.code-actions.typescript'

local prettier_filetypes = {
	"css",
	"graphql",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"less",
	"markdown",
	"scss",
	"typescript",
	"typescriptreact",
	"yaml",
}

null_ls.setup({
	sources = {
		-- Code actions
		--code_actions.gitsigns,
		typescript_actions,
		code_actions.refactoring,

		-- Formatting
		formatting.prettier.with({ filetypes = prettier_filetypes, timeout = 5000 })
	}
})
