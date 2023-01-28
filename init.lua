local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/completion-nvim'
	use 'nvim-lua/lsp-status.nvim'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'github/copilot.vim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-media-files.nvim'
	use 'nvim-telescope/telescope-project.nvim'
	use 'nvim-telescope/telescope-symbols.nvim'
	use 'LnL7/vim-nix'
end)

-- vim options from init.vim
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.cmd("colorscheme slate")
vim.cmd("syntax on")
