-- packer
local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/completion-nvim'
	use 'nvim-lua/lsp-status.nvim'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'github/copilot.vim'
	use 'LnL7/vim-nix'
	use 'kkvh/vim-docker-tools'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/telescope.nvim'
end)

-- vim options from init.vim
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd("colorscheme slate")
vim.cmd("syntax on")

-- telescope
local builtin = require('telescope.builtin')
--vim.keymap.set('n', ' ', builtin.find_files {})
vim.cmd("nnoremap <Space> <cmd>Telescope find_files<CR>")

-- lsp
require'nvim-lsp-installer'.setup{}
require'lspconfig'.pyright.setup{}
