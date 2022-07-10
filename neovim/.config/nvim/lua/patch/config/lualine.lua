-- Component references
-- https://github.com/nvim-lualine/lualine.nvim#changing-components-in-lualine-sections
--
-- Available components
--
--      branch (git branch)
--      buffers (shows currently available buffers)
--      diagnostics (diagnostics count from your preferred source)
--      diff (git diff status)
--      encoding (file encoding)
--      fileformat (file format)
--      filename
--      filesize
--      filetype
--      hostname
--      location (location in file in line:column format)
--      mode (vim mode)
--      progress (%progress in file)
--      tabs (shows currently available tabs)
--      windows (shows currently available windows)

require "patch.utils".safe_setup('tabline', {
	enable = true,
	options = {
		-- If lualine is installed tabline will use separators configured in lualine by default.
		-- These options can be used to override those settings.
		show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
		show_devicons = true, -- this shows devicons in buffer section
		show_bufnr = false, -- this appends [bufnr] to buffer section,
		show_filename_only = true, -- shows base filename only instead of relative path in filename
		modified_icon = "[+] ", -- change the default modified icon
		modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
		show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
	}
})

require "patch.utils".safe_setup('lualine', {
	options = {
		icons_enabled = true,
		theme = 'gruvbox',
		--theme = 'onedark',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1, file_status = true } },
		lualine_x = { 'filesize', 'filetype' },
		lualine_y = {},
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
})

vim.cmd([[
    set guioptions-=e
    set sessionoptions+=tabpages,globals
]])
