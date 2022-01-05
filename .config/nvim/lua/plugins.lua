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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

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
		"hrsh7th/nvim-compe",
		"sbdchd/neoformat",
		"folke/trouble.nvim",
		{"ms-jpq/coq_nvim", branch = "coq"},
		{"ms-jpq/coq.artifacts", branch = "artifacts"},
		"neoclide/coc.nvim",
		"natebosch/vim-lsc"
		-- {"ray-x/navigator.lua", requires = {"ray-x/guihua.lua", run = "cd lua/fzy && make"}}
	}

	-- Snippets
	use {
		"rafamadriz/friendly-snippets",
		"Shougo/neosnippet.vim",
		"Shougo/neosnippet-snippets"
	}

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
		"p00f/nvim-ts-rainbow"
	}

	-- Git
	use "lewis6991/gitsigns.nvim"

	-- File manager
	-- Statusline and bufferline
	-- use { "glepnir/galaxyline.nvim"}
	use {
		-- "romgrk/barbar.nvim",
		"kyazdani42/nvim-web-devicons",
		"kyazdani42/nvim-tree.lua",
		"akinsho/bufferline.nvim",
		"famiu/feline.nvim",
		requires = {"kyazdani42/nvim-web-devicons"}
	}


	-- Markdown
	use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

	-- JS/html
	-- "othree/yajs.vim",
	-- "yuezk/vim-js",
	use {
		"scrooloose/syntastic",
		"groenewege/vim-less",
		"hail2u/vim-css3-syntax",
		"maxmellon/vim-jsx-pretty",
		"pangloss/vim-javascript",
		"ryym/vim-riot",
		"mattn/emmet-vim",
		{"vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim"}
	}

	-- Terraform
	use {
		'hashivim/vim-terraform',
		'juliosueiras/vim-terraform-completion'
	}

	-- Terminal
	use {"akinsho/nvim-toggleterm.lua", "voldikss/vim-floaterm"}

	-- General plugins
	use {
		"karb94/neoscroll.nvim",
		"glepnir/dashboard-nvim",
		"b3nj5m1n/kommentary",
		"glepnir/indent-guides.nvim",
		"windwp/nvim-autopairs",
		"norcalli/nvim-colorizer.lua",
		"RRethy/vim-illuminate",
		"mg979/vim-visual-multi",
		"tpope/vim-surround",
		"ggandor/lightspeed.nvim",
		-- "blueyed/vim-diminactive"
	}

	-- Themes
	--"norcalli/nvim-base16.lua",
	use {
		{"catppuccin/nvim", branch = "main"},
		-- {"catppuccin/nvim", branch = "old-catppuccino"},
		"rebelot/kanagawa.nvim",
		"EdenEast/nightfox.nvim",
		-- "srcery-colors/srcery-vim",
		-- "ntk148v/vim-horizon",
		"christianchiarulli/nvcode-color-schemes.vim",
		"chriskempson/base16-vim",
		-- "tiagovla/tokyodark.nvim"
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
