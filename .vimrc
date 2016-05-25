set nocompatible              " be iMproved, required
filetype off                  " required

set t_Co=256
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

set tags=~/Git/tachyon/.tags,~/Git/higgs/.tags,~/Git/heisenberg/.tags,~/Git/tachyon-storage/.tags,~/Git/chronotrack-protocols/.tags

set number
set relativenumber


call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'craigemery/vim-autotag'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'bling/vim-bufferline'
Plugin 'powerline/powerline'
Plugin 'Conque-GDB'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
silent! map <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeToggle="<F2>"
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
let g:EclimCompletionMethod = 'omnifunc'
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/target/*,*.swo,*.swp,*/dist/*,*/node_modules/*,*/lib/*,*/export/*,/bin/*,*.class
let g:ctrlp_working_path_mode = '~/Git'
au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim
silent! map <F4> :ProjectProblems! <CR>
noremap <C-]> <C-]>:tl<CR>
silent! nmap <C-p> :CtrlP<CR>

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



