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
	use 'williamboman/nvim-lsp-installer'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/telescope.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'elixir-editors/vim-elixir'
    use 'elixir-tools/elixir-tools.nvim'
end)

-- vim options from init.vim
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd("colorscheme slate")
vim.cmd("syntax on")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- telescope
local builtin = require('telescope.builtin')
--vim.keymap.set('n', ' ', builtin.find_files {})
vim.cmd("nnoremap <Space> <cmd>Telescope find_files<CR>")
-- vim.cmd("nnoremap <C-Space> <cmd>20 split term://bash<CR>")


-- auto complete


local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<C-CR>'] = cmp.mapping.confirm({ 
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
	}),
	sources = {
		{ name = 'vsnip' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'calc' },
		{ name = 'emoji' },
		{ name = 'treesitter' },
		{ name = 'crates' },
	},
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp
require'nvim-lsp-installer'.setup{capabilities = capabilities}
require'lspconfig'.rust_analyzer.setup{capabilities = capabilities}
require'lspconfig'.gopls.setup{capabilities = capabilities}
require'lspconfig'.sqlls.setup{capabilities = capabilities}
require'lspconfig'.jdtls.setup{capabilities = capabilities}
require'lspconfig'.ccls.setup{capabilities = capabilities}
require'lspconfig'.jedi_language_server.setup{capabilities = capabilities}
require'lspconfig'.omnisharp.setup{capabilities = capabilities}


local elixir = require("elixir")
elixir.setup({
    cmd = { "/home/lia/code/git/gh/elixir-ls/release/language_server.sh" },
})
