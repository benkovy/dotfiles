let mapleader = ","
let g:mapleader = ","
nmap <leader>v :split ~/.config/nvim/init.vim<CR>

" PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-commentary'

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

Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'noprompt/vim-yardoc'    

Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'

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
set number " show current absolute line
set hidden
set nocompatible
set noshowmode

set mouse=a
set clipboard^=unnamed " use the system register for clipboard
set whichwrap+=<,>,h,l " Let movement wrap
set shiftwidth=2
set tw=80 	       " Limit line length
set colorcolumn=80 " and give me a colored column

set backspace=eol,start,indent " Let backspace wrap
set whichwrap+=<,>,h,l         " Let movement wrap
set expandtab                  " Use spaces instead of tabs
set smarttab                   " Be smart when using tabs ;)
set ignorecase                 " Case insensitive search
set cindent
set tabstop=2
set shiftwidth=2
set expandtab " always uses spaces instead of tab characters
set undofile

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nmap <silent> [t :tabprevious<cr>
nmap <silent> ]t :tabnext<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" sus q to go back
map q b

" Sane splitting
nmap \\ :vsplit<cr>
nmap -- :split<cr>
nmap <bar><bar> :bd<cr> 

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

nmap <silent> <c-p> :GFiles<CR>
nmap <silent> <c-t> :Buffers<CR>
nmap <silent> <c-f> :GGrep<CR>

" ===============================
" COC improvements
" ===============================

" ctrl space to bring up completion
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> M :call CocActionAsync('doHover')<cr>

" ===============================
" End COC improvements
" ===============================

" Search clearing
nnoremap <CR> :noh<CR><CR>

" NERDTree
let NERDTreeShowHidden=1 " Always show dot (hidden) files
let NERDTreeQuitOnOpen=1 " Close the NERDTree after opening a file
nmap <silent> nt :NERDTreeFind<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* GGrepNoTests
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

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


" Session management

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

