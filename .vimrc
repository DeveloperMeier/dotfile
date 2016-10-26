set nocompatible              " be iMproved, required
filetype off                  " required

set t_Co=256
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set mouse=a
"set tags=~/Git/tachyon/.tags,~/Git/higgs/.tags,~/Git/heisenberg/.tags,~/Git/tachyon-storage/.tags,~/Git/chronotrack-protocols/.tags,.tags,~/Git/tachyon-web/.tags,~/Git/jajvam/.tags,~/Git/jajvam-web/.tags
set tags=~/Git/Projects/Jajvam/jajvam/.tags,~/Git/Projects/Jajvam/jajvam-web/.tags,~/Git/Projects/Jajvam/ares/.tags
set number
set relativenumber
set shortmess=a
set cmdheight=3

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=M  "remove system toolbar
set guioptions+=a  "Global windowing access
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap fileswset noswapfile

":set guioptions-=r  "remove right-hand scroll bar
":set guioptions-=L  "remove left-hand scroll bar<
"hi Normal ctermbg=none
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
let g:jsx_ext_required = 0

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'craigemery/vim-autotag'
Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'bling/vim-bufferline'
Plugin 'powerline/powerline'
Plugin 'Conque-GDB'
Plugin 'pangloss/vim-javascript'
Plugin 'webdevel/tabulous'
Plugin 'ap/vim-buftabline'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'mxw/vim-jsx'
Plugin 'ternjs/tern_for_vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'othree/html5-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jaxbot/syntastic-react'
Plugin 'scrooloose/nerdtree'
Plugin 'derekwyatt/vim-sbt'
Plugin 'gre/play2vim'
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'spiroid/vim-ultisnip-scala'
Plugin 'kien/ctrlp.vim'
Plugin 'takac/vim-spotifysearch'
Plugin 'tommorris/scala-vim-snippets'
Plugin 'honza/vim-snippets'
Plugin 'moll/vim-node'
Plugin 'SirVer/ultisnips'
Plugin 'FredKSchott/CoVim'
Plugin 'vim-scripts/groovy.vim'


"map <C-p> [unite]p
" open ctag in tab/vertical split
map <C-\> :split<CR>:exec("tag ".expand("<cword>"))<CR>
map <leader>\ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


let g:syntastic_javascript_checkers = ['eslint']

set nowrap


let g:jsx_ext_required = 0
let g:used_javascript_libs = 'react,underscore,angularjs,jasmine,chai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
color Monokai
hi normal ctermbg=16 ctermfg=214 guifg=214 guibg=16
hi NonText ctermfg=214 ctermbg=16 guifg=214 guibg=16

set background=dark

filetype plugin indent on    " required

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
execute pathogen#infect()
call pathogen#helptags()
let mapleader=","
silent! map <F2> :NERDTreeToggle<CR>
let g:NERDTreeToggle="<F2>"
let g:NERDTreeMapActivateNode="<F6>"
let g:NERDTreeMapPreview="<F4>"
let g:EclimCompletionMethod = 'omnifunc'
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/target/*,*.swo,*.swp,*/dist/*,*/node_modules/*,*/lib/*,*/export/*,/bin/*,*.class
let g:ctrlp_working_path_mode = '~/Git/Projects'
au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim
silent! map <F4> :ProjectProblems! <CR>
noremap <C-]> <C-]>:tl<CR>
noremap <Leader>t :tags<CR>
"silent! nmap <C-p> :CtrlP ~/Git/Projects<CR>
"silent! nmap <Leader>b :CtrlPBuffer<CR>

"Airline Settings"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"FuzzyFinder Settings"

noremap <C-f>b :FufBuffer<CR>
noremap <C-f>t :FufTag<CR>
noremap <C-f>f :FufFile<CR>


"Indent-Guides settings"
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4


"Custom Commands"
noremap <C-z> :! source ~/.bashrc && cfv<CR>
nmap <Leader>j :bn<CR>
nmap <Leader>k :bp<CR>
noremap <C-o> :ScalaImport<CR>
nnoremap <C-]> g<C-]>
noremap <C-=> :TagbarShowTag<CR>
noremap <C-b> :BuffersToggle<CR>

function! s:GrepFor (text)
    return vimgrep /text/g % | copen
endfunction

filetype plugin on
set runtimepath^=~/.vim/bundle/tabulous


let CoVim_default_name = "colby"
let CoVim_default_port = "9999"

