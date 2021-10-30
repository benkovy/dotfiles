let mapleader = ","
let g:mapleader = ","
nmap <leader>v :split ~/.config/nvim/init.vim<CR>

" PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'

Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
Plug 'airblade/vim-gitgutter' 

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'TaDaa/vimade'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'thoughtbot/vim-rspec'
Plug 'noprompt/vim-yardoc'    

" Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

colorscheme gruvbox 

let g:palenight_terminal_italics=1

set relativenumber
set hidden
set nocompatible

set mouse=a
set clipboard^=unnamed " use the system register for clipboard
set whichwrap+=<,>,h,l " Let movement wrap
set shiftwidth=2
set tw=80 	       " Limit line length

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab " always uses spaces instead of tab characters

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nmap <silent> [t :tabprevious<cr>
nmap <silent> ]t :tabnext<cr>

" Move between windows like cbothner :)
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

nmap <silent> <c-p> :GFiles<CR>
nmap <silent> <c-t> :Buffers<CR>
nmap <silent> <c-f> :GGrep<CR>

map <leader>bb :bd<cr>
vmap <silent> ++ <plug>NERDCommenterToggle
nmap <silent> ++ <plug>NERDCommenterToggle

" ctrl space to bring up completion
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" NERDTree
let NERDTreeShowHidden=1 " Always show dot (hidden) files
let NERDTreeQuitOnOpen=1 " Close the NERDTree after opening a file
nmap <silent> nt :NERDTreeFind<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json' ]











