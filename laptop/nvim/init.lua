local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()
require('pckr').add({
	'wbthomason/packer.nvim',
	'neovim/nvim-lspconfig',
	'nvim-lua/completion-nvim',
	'nvim-lua/lsp-status.nvim',
	'nvim-lua/lsp_extensions.nvim',
	'github/copilot.vim',
	'LnL7/vim-nix',
	'kkvh/vim-docker-tools',
	'williamboman/nvim-lsp-installer',
	'nvim-lua/plenary.nvim',
	'nvim-lua/telescope.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	'elixir-editors/vim-elixir',
	'elixir-tools/elixir-tools.nvim',
	'vimwiki/vimwiki'
})

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
require'lspconfig'.pyright.setup{capabilities = capabilities}
require'lspconfig'.omnisharp.setup{capabilities = capabilities}


local elixir = require("elixir")
elixir.setup({
    cmd = { "/home/lia/code/git/gh/elixir-ls/release/language_server.sh" },
})
