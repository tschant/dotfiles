#!/bin/bash
# Install packer for nvim
[[ -f "~/.local/share/nvim/site/pack/packer/start/packer.nvim" ]] || git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
