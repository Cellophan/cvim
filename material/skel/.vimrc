"SRC https://github.com/VundleVim/Vundle.vim
set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
" Plugin 'fatih/molokai'
Plugin 'bling/vim-airline'
Plugin 'shougo/neocomplete.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter' "plugin fugitive?
" Plugin 'scrooloose/syntastic'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'editorconfig/editorconfig-vim'

" based on https://statico.github.io/vim3.html
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'

"See http://gorefactor.org/starting.html
" Plugin 'godoctor/godoctor.vim'

" Plugin 'z0mbix/vim-shfmt'

Plugin 'dense-analysis/ale'

Plugin 'ludovicchabant/vim-gutentags'

" Collaborative editing with neovim
"Plugin 'jbyuti/instant.nvim'

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

"inspired from https://github.com/mbrt/go-docker-dev/blob/master/fs/home/dev/.vimrc
syn on
set hlsearch
set background=light
set showcmd
set splitbelow

"set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,./*/tags,tags
autocmd FileChangedShell * echo "Warning: File changed (for reloading: :edit :edit!)."
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" FileType list found in filetype.vim
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

let mapleader=","

" Inspired from https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
nmap <C-Right> :bnext<CR>
nmap <C-Left> :bprevious<CR>
nmap <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nmap <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
"  Resize: http://vim.wikia.com/wiki/Resize_splits_more_quickly
nmap <Leader>* :exe "resize " . (heighwidth(0) * 3/2)<CR>
nmap <Leader>/ :exe "resize " . (heighwidth(0) * 2/3)<CR>
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
"  Mouse toggle
nnoremap <leader>m :call ToggleMouse()<cr>
function! ToggleMouse()
  if &mouse == ""
    setlocal mouse=a
  else
    setlocal mouse=
  endif
endfunction
"  Hightlight toggle
nnoremap <F4> :noh<CR>
"  my Shell (but can't use set shell because this would break the plugins)
" nnoremap <F5> :! czsh<CR>
nnoremap <F5> :term czsh<CR>
"  spell
nnoremap <F6> :call ToggleSpell()<CR>
function! ToggleSpell()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction
"  From http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'Entered:    ' . a:cmdline)
  call setline(2, 'Expanded:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

"http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
"http://codeyarns.com/2011/07/29/vim-set-color-of-colorcolumn/
":help ctermbg
" highlight ColorColumn ctermbg=7
" let &colorcolumn="80,".join(range(130,131),",")

"Plugin customizations
" neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
"let g:airline#extensions#tabline#enabled = 1
"    Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1
"    Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
"   Activate powerline symbols
"let g:airline_powerline_fonts = 1
"   https://github.com/vim-airline/vim-airline/wiki/FAQ
"   http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=16

" tagbar
nmap <F3> :TagbarToggle<CR>
"   :TagbarGetTypeConfig python

" NERDTree
nmap <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
" Open NERDTree if vim is called without files
autocmd VimEnter * if !argc() | NERDTree | endif
" Close NERDTree if it's the last window buffer opened
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"" Based on 'Using with Syntastic' https://github.com/fatih/vim-go
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"Bundle 'molokai'
"let g:rehash256 = 1

"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'

" Plugin 'mileszs/ack.vim'
" Plugin 'junegunn/fzf.vim'
let g:ackprg = 'ag --nocolor --vimgrep'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" vim-shfmt
let g:shfmt_extra_args = '-i 2'
"let g:shfmt_fmt_on_save = 1

" Plugin 'dense-analysis/ale'
" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" Folding!
" Based on:
"   * https://www.linux.com/training-tutorials/vim-tips-folding-fun/
"   * http://vimdoc.sourceforge.net/htmldoc/fold.html#za
"   * https://unix.stackexchange.com/questions/141097/how-to-enable-and-use-code-folding-in-vim
"   * https://web.archive.org/web/20161016081350/http://smartic.us/2009/04/06/code-folding-in-vim/
" Notes: Then you can toggle folding with za. You can fold everything with zM and unfold everything with zR. zm and zr can be used to get those folds just right. Always remember the almighty help file at “help :folding” if you get stuck.
set foldmethod=indent
set foldnestmax=10
"set nofoldenable
set foldlevel=20
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction
autocmd Filetype markdown setlocal foldexpr=MarkdownLevel()
autocmd Filetype markdown setlocal foldmethod=expr

" Plugin 'dense-analysis/ale'
" https://github.com/dense-analysis/ale/tree/master/doc
let g:ale_dockerfile_hadolint_use_docker = 'yes'
let g:ale_linters = {
                \ 'sh': ['bashate'],
                \ 'python': ['flake8', 'pylint'],
                \ 'yaml': ['pylint'], 'dockerfile': ['hadolint']
            \ }
let g:ale_fixers = {'python': ['black']}
" https://github.com/openstack/bashate
let g:ale_sh_bashate_options = '-i E006'

" Plugin 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_tagfile = ".tags"

imap jk <ESC>
imap kj <ESC>

