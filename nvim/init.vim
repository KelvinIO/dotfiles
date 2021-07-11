set clipboard+=unnamedplus
set cursorline
set expandtab
set noshowmode
set number
set relativenumber
set shiftwidth=2
set shortmess+=c
set termguicolors
set undofile
set visualbell
set wrap

" Keybinds
nnoremap <C-t> :bn<CR> 

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dikiaap/minimalist'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'jiangmiao/auto-pairs'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'folke/tokyonight.nvim'
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

" Colorscheme
filetype plugin indent on
syntax enable
set t_Co=256
set encoding=utf-8
set guifont=Iosevka

let g:palenight_color_overrides = {
\    'black': { 'gui': '#171717', "cterm": "0", "cterm16": "0" },
\}

colorscheme palenight

" Tree SItter Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

" Plugin Setups
lua require'colorizer'.setup()

" Autocompletion
set completeopt=menuone,noselect

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 2;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
    omni = {
            filetypes = {'tex'},
        },
  };
}
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" LSP Setup
lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.clangd.setup{}
require 'lspconfig'.tsserver.setup{}
EOF


"LaTeX Setup
" Live Preview
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'xelatex'

" Vimtex
let g:vimtex_view_general_viewer = 'zathura'

" Airline.
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
