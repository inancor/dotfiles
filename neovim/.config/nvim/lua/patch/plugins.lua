local req = require 'patch.utils'.safe_require

return require 'patch.utils.bootstrap'.bootstrap_packer(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- Help things go faster, because who wouldn't love to save up to 40ms on launch?
	use "lewis6991/impatient.nvim"

	-- Lightspeed navigation!
	use "ggandor/lightspeed.nvim"

	-- Clipboard history
	use {
		"AckslD/nvim-neoclip.lua",
		requires = { { 'tami5/sqlite.lua', module = 'sqlite' } },
	}

	use 'norcalli/nvim-colorizer.lua'

	---------------------------
	--       Telescope
	---------------------------

	-- Telescope and its peripheries
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope-symbols.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-project.nvim",
		}
	}

	-- Make things PRETTY
	use 'stevearc/dressing.nvim'

	---------------------------
	--      Tree Sitter
	---------------------------

	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"windwp/nvim-ts-autotag",

			-- Auto pair braces
			"windwp/nvim-autopairs",

			"p00f/nvim-ts-rainbow",

			"ThePrimeagen/refactoring.nvim",

			-- Some additional treesitter functionality
			"nvim-treesitter/nvim-treesitter-textobjects",
			"theHamsta/nvim-treesitter-pairs",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/playground",
			"nvim-treesitter/tree-sitter-lua",
		}
	}

	use {
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/typescript.nvim",
			-- Add the signature between the braces
			"ray-x/lsp_signature.nvim"
		}
	}

	-- Autocompletion plugin
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			-- LSP source for nvim-cmp
			"hrsh7th/cmp-nvim-lsp",

			-- Use completions from the buffer
			"hrsh7th/cmp-buffer",

			-- Use completions from the path
			"hrsh7th/cmp-path",

			-- Add completions to the cmdline
			"hrsh7th/cmp-cmdline",

			-- Snippet engines
			"saadparwaiz1/cmp_luasnip",
		}
	}

	-- Snippets
	use {
		"L3MON4D3/LuaSnip",
		requires = { "honza/vim-snippets" }
	}

	-- Add prettier support
	use {
		'jose-elias-alvarez/null-ls.nvim',
		requires = {
			'MunifTanjim/prettier.nvim',
			"nvim-lua/plenary.nvim",
		}
	}

	---------------------------
	--          Misc
	---------------------------

	-- Commenting tool
	use 'numtostr/comment.nvim'

	-- File explorer
	use "kyazdani42/nvim-tree.lua"

	-- Rooter changes the working directory to the project root when you open a file or directory.
	use "airblade/vim-rooter"

	-- Notifications!
	use 'rcarriga/nvim-notify'

	-- Install lualine and tabline
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kdheepak/tabline.nvim" }
	}

	-- Some tpope features
	use "tpope/vim-surround"
	use "tpope/vim-fugitive"
	use "tpope/vim-obsession"

	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" }
	}

	-- Improve the slash-search functionality
	use "junegunn/vim-slash"

	-- Themes
	use {
		"sainnhe/gruvbox-material",
		"RRethy/nvim-base16"
	}
end)
