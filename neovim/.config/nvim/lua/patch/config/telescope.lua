require "patch.utils".safe_setup('telescope', { -- BEGIN_DEFAULT_OPTS
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
		},
	},
	extensions = {
		project = {
			base_dirs = { "~/dev" },
			theme = "dropdown"
		}
	}
})

require 'telescope'.load_extension('project')
