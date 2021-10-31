let mapleader = ","
let g:mapleader = ","
nmap <leader>v :split ~/.config/nvim/init.vim<CR>

" PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'

Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
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

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
set background=dark
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard

set relativenumber
set number " Also show current absolute line
set hidden
set nocompatible
set noshowmode

set mouse=a
set clipboard^=unnamed " use the system register for clipboard
set whichwrap+=<,>,h,l " Let movement wrap
set shiftwidth=2
set tw=80 	       " Limit line length
set colorcolumn=80 " and give me a colored column

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab " always uses spaces instead of tab characters
set splitbelow
set splitright
set timeoutlen=1000
set ttimeoutlen=50

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

" Use left and right to move through buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Use tabs to move through popups
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

nmap <silent> <c-p> :Files<CR>
nmap <silent> <c-t> :Buffers<CR>
nmap <silent> <c-f> :GGrep<CR>

map <leader>bb :bd<cr>

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
  \ 'coc-graphql',
  \ 'coc-json' ]

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'FugitiveHead'
      \
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction










