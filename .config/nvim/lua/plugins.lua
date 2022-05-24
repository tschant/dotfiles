local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use {"wbthomason/packer.nvim"}

	-- LSP, Autocomplete
	use {
		"onsails/lspkind-nvim",
		"neovim/nvim-lspconfig",
		"sbdchd/neoformat",
		"folke/trouble.nvim",
		"natebosch/vim-lsc",
		-- "mfussenegger/nvim-jdtls",
		"j-hui/fidget.nvim",
		"fladson/vim-kitty"
	}

	-- nvim-cmp snippets/completion
	use {
		"hrsh7th/nvim-cmp",
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	}

	-- COQ snippet/completion
	--[[ use {
		{"ms-jpq/coq_nvim", branch = "coq"},
		{"ms-jpq/coq.artifacts", branch = "artifacts"},
	} ]]

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			{"nvim-lua/popup.nvim"},
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope-fzy-native.nvim"},
			{"nvim-telescope/telescope-media-files.nvim"},
			-- {"nvim-telescope/telescope-project.nvim"},
			("ahmedkhalf/project.nvim")
		}
	}

	-- Treesitter
	use {
		{"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
		"windwp/nvim-ts-autotag",
		"p00f/nvim-ts-rainbow",
		"ziontee113/syntax-tree-surfer"
	}

	use {
		'rmagatti/auto-session',
		config = function()
			require('auto-session').setup {
				log_level = 'info',
				auto_restore_enabled = true,
				auto_session_use_git_branch = true,
				auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
			}
		end
	}

	-- Git
	use {
		"lewis6991/gitsigns.nvim"
	}

	-- File manager
	-- Statusline and bufferline
	use {
		"kyazdani42/nvim-web-devicons",
		"kyazdani42/nvim-tree.lua",
		-- {"akinsho/bufferline.nvim", branch = "main"},
		"romgrk/barbar.nvim",
		"feline-nvim/feline.nvim",
		requires = {"kyazdani42/nvim-web-devicons"}
	}


	-- Markdown
	use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

	-- JS/html
	use {
		"scrooloose/syntastic",
		"groenewege/vim-less",
		"hail2u/vim-css3-syntax",
		"maxmellon/vim-jsx-pretty",
		"pangloss/vim-javascript",
		"ryym/vim-riot",
		"mattn/emmet-vim",
		-- {"vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim"}
	}

	-- Terraform
	use {
		'hashivim/vim-terraform',
		'juliosueiras/vim-terraform-completion'
	}

	-- Terminal
	use {
		{"akinsho/nvim-toggleterm.lua", branch = "main"}, 
		"voldikss/vim-floaterm"
	}

	-- Window splitting
	use {
		"nyngwang/NeoZoom.lua",
		"beauwilliams/focus.nvim",
	}

	use {
		"numToStr/Comment.nvim", tag = "v0.6"
	}

	-- Notes
	use {
		"vimwiki/vimwiki"
	}

	-- General plugins
	use {
		"mbbill/undotree",
		"karb94/neoscroll.nvim",
		"glepnir/dashboard-nvim",
		"glepnir/indent-guides.nvim",
		"lukas-reineke/indent-blankline.nvim",
		"windwp/nvim-autopairs",
		"norcalli/nvim-colorizer.lua",
		"RRethy/vim-illuminate",
		"mg979/vim-visual-multi",
		"tpope/vim-surround",
		"ggandor/lightspeed.nvim",
		{"anuvyklack/pretty-fold.nvim", requires = 'anuvyklack/nvim-keymap-amend'},
		"petertriho/nvim-scrollbar",
		"kevinhwang91/nvim-hlslens",
		"ojroques/nvim-bufdel",
		"dstein64/vim-startuptime",
	}

	-- Themes
	--"norcalli/nvim-base16.lua",
	use {
		{"catppuccin/nvim", branch = "main"},
		-- {"catppuccin/nvim", branch = "old-catppuccino"},
		"rebelot/kanagawa.nvim",
		"EdenEast/nightfox.nvim",
		"srcery-colors/srcery-vim",
		"christianchiarulli/nvcode-color-schemes.vim",
		"chriskempson/base16-vim",
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
