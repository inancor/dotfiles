require "patch.utils".safe_setup('nvim-treesitter.configs', {
	autotag = {
		enable = true,
	},
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = false,
		max_file_lines = nil,
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aC"] = "@conditional.outer",
				["iC"] = "@conditional.inner",
				["aS"] = "@tag.self-closing",
				["ap"] = "@json.property",
			},
		},
	},
	refactor = {
		-- Highlights definition and usages of the current symbol under the cursor.
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},

		-- Highlights the block from the current scope where the cursor is.
		highlight_current_scope = { enable = false },

		-- Renames the symbol under the cursor within the current scope (and current file).
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "<leader>rr",
			},
		},

		-- Provides "go to definition" for the symbol under the cursor, and lists the definitions from the current file.
		-- If you use goto_definition_lsp_fallback instead of goto_definition in the config below vim.lsp.buf.definition
		-- is used if nvim-treesitter can not resolve the variable. goto_next_usage/goto_previous_usage go to the next usage
		-- of the identifier under the cursor.
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
			},
		},
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false
	},

	-- View treesitter information directly in Neovim!
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	}
})
