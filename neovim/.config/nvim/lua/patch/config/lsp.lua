local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local default_servers = {
	-- Angular
	--  npm install -g @angular/language-server
	["angularls"] = {},
	--["angularls"] = require 'patch.config.lsp-overrides'.angular(),

	-- Bash
	--  npm i -g bash-language-server
	["bashls"] = {},

	-- CSS, ESLint, HTML and JSON
	--  npm i -g vscode-langservers-extracted cssmodules-language-server
	["cssls"] = {},
	-- ["eslint"] = {},
	["html"] = {},
	["jsonls"] = {},

	-- CSS Modules
	--  npm i -g cssmodules-language-server
	["cssmodules_ls"] = {},

	-- Diagnostic language server integrate with linters
	["diagnosticls"] = {},

	-- Docker
	--  npm install -g dockerfile-language-server-nodejs
	["dockerls"] = {},

	-- Emmet support
	--  npm install -g emmet-ls
	["emmet_ls"] = {},

	-- Typescript
	--  npm install -g typescript typescript-language-server
	--["tsserver"] = {},
	--[[ ["typescript"] = {
		 [   disable_commands = true,
		 [   disable_formatting = true,
		 [ }, ]]

	-- VimL
	--  npm install -g vim-language-server
	["vimls"] = {},

	-- YAML
	--  npm i -g yaml-language-server
	["yamlls"] = {},

	-- Rust
	["rust_analyzer"] = {},

	-- Lua
	-- ["sumneko_lua"] = {}
	["sumneko_lua"] = {
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	}
}


-- if you want to set up formatting on save, you can use this as a callback
local lspFormatAUGroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Mappings.
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local lsp = vim.lsp.buf

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", lsp.declaration, opts)
	vim.keymap.set("n", "gd", lsp.definition, opts)
	vim.keymap.set("n", "K", lsp.hover, opts)
	vim.keymap.set("n", "gi", lsp.implementation, opts)
	-- vim.keymap.set("n", "<C-K>", lsp.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", lsp.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", lsp.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(lsp.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "gT", lsp.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", lsp.rename, opts)
	vim.keymap.set("n", "<C-space>", lsp.code_action, opts)
	vim.keymap.set("n", "gr", lsp.references, opts)
	vim.keymap.set("n", "<leader>f", lsp.formatting, opts)

	--[[ if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { callback = lsp.document_highlight, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { callback = lsp.clear_references, buffer = bufnr })
	end ]]

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = lspFormatAUGroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lspFormatAUGroup,
			buffer = bufnr,
			callback = function()
				require 'patch/utils/format'.lsp_formatting(bufnr)
			end,
		})
	end

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local req = require 'patch.utils'.safe_require
req("cmp_nvim_lsp", function(nlsp) capabilities = nlsp.update_capabilities(capabilities) end)

require 'typescript'.setup {
	disable_commands = true,
	disable_formatting = true,
	debug = false,
	server = {}
}

for lsp, config in pairs(default_servers) do
	local default = { on_attach = on_attach, capabilities = capabilities }
	local opts = vim.tbl_deep_extend("force", default, config)

	lspconfig[lsp].setup(opts)
end

require "patch.utils".safe_setup("nvim-lsp-installer", {
	-- A list of servers to automatically install. Example: { "rust_analyzer", "sumneko_lua" }
	ensure_installed = { "sumneko_lua", "diagnosticls" },
	ui = {
		icons = {
			-- The list icon to use for installed servers.
			server_installed = "✓",
			-- The list icon to use for servers that are pending installation.
			server_pending = "➜",
			-- The list icon to use for servers that are not installed.
			server_uninstalled = "✗",
		},
		keymaps = {
			-- Keymap to expand a server in the UI
			toggle_server_expand = "<CR>",
			-- Keymap to install the server under the current cursor position
			install_server = "i",
			-- Keymap to reinstall/update the server under the current cursor position
			update_server = "u",
			-- Keymap to check for new version for the server under the current cursor position
			check_server_version = "c",
			-- Keymap to update all installed servers
			update_all_servers = "U",
			-- Keymap to check which installed servers are outdated
			check_outdated_servers = "C",
			-- Keymap to uninstall a server
			uninstall_server = "X",
		},
	},

	-- The directory in which to install all servers.
	install_root_dir = require "nvim-lsp-installer.core.path".concat({ vim.fn.stdpath("data"), "lsp_servers" }),

	-- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
	-- servers that are requested to be installed will be put in a queue.
	max_concurrent_installers = 4,
})
