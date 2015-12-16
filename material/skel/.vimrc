"inspired from https://github.com/mbrt/go-docker-dev/blob/master/fs/home/dev/.vimrc
syn on
set hlsearch
set background=light
set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,./*/tags,tags
autocmd FileChangedShell * echo "Warning: File changed (for reloading: :edit :edit!)."
set ts=4 sts=4 sw=4
"autocmd Filetype python setlocal et ts=4 sts=4 sw=4

let mapleader=","

"SRC https://github.com/VundleVim/Vundle.vim
set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/molokai'
Plugin 'bling/vim-airline'
"Plugin 'tpope/vim-fugitive'
Plugin 'shougo/neocomplete.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"/SRC https://github.com/VundleVim/Vundle.vim

" vim-go
" :help vim-go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>o :GoInstall -x<CR>

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

"Perso
" Inspired from https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
nmap <C-Right> :bnext<CR>
nmap <C-Left> :bprevious<CR>
nmap <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nmap <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
"  Cherypicked from https://github.com/farazdagi/vim-go-ide/blob/master/vimrc/basic.vim
"    Ignore case when searching
set ignorecase
set encoding=utf8
"    highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
"http://codeyarns.com/2011/07/29/vim-set-color-of-colorcolumn/
":help ctermbg
highlight ColorColumn ctermbg=7
let &colorcolumn="80,".join(range(130,999),",")

"Plugin customizations
"neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
"    Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"    Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" tagbar
nmap <F3> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

"NERDTree
nmap <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
" Open NERDTree if vim is called without files
autocmd VimEnter * if !argc() | NERDTree | endif
" Close NERDTree if it's the last window buffer opened
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Based on 'Using with Syntastic' https://github.com/fatih/vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"Bundle 'molokai'
let g:rehash256 = 1


"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
