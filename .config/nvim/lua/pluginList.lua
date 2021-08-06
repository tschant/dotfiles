local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute "packadd packer.nvim"
end

return require("packer").startup(
	function()
		use {"wbthomason/packer.nvim"}

		-- LSP, Autocomplete
		use {
			"onsails/lspkind-nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-compe",
			"sbdchd/neoformat",
			"neoclide/coc.nvim"
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
				{"nvim-telescope/telescope-media-files.nvim"}
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
		use {
			"kyazdani42/nvim-tree.lua",
			requires = {"kyazdani42/nvim-web-devicons"}
		}


		-- Markdown
		use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
		use "junegunn/goyo.vim"

		-- JS/html
		-- "othree/yajs.vim",
		-- "yuezk/vim-js",
		-- "pangloss/vim-javascript",
		use {
			"scrooloose/syntastic",
			"groenewege/vim-less",
			"hail2u/vim-css3-syntax",
			"maxmellon/vim-jsx-pretty",
			"ryym/vim-riot",
			"mattn/emmet-vim"
		}

		-- Terraform
		use {
			'hashivim/vim-terraform',
			'juliosueiras/vim-terraform-completion'
		}

		-- Statusline and bufferline
		use {"romgrk/barbar.nvim", "glepnir/galaxyline.nvim"}

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
			"ggandor/lightspeed.nvim"
		}

		-- Themes
			--"norcalli/nvim-base16.lua",
		use {
			"srcery-colors/srcery-vim",
			-- "ntk148v/vim-horizon",
			"christianchiarulli/nvcode-color-schemes.vim",
			"chriskempson/base16-vim",
			"tiagovla/tokyodark.nvim"
		}
	end
)
