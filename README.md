# dotfile
## How to set up VIM to use in lieu of IntelliJ	
### Required System Components
		_CTags_ -- Decompiling for symbol matching
		_Eclim_ -- Run Eclipse headlessly for compiling
		_Vim_   -- Best editor ever
		_Eclipse_ *(only the .tar.gz, not the installer)*
### Required VIM Components
		_Vundle_    	 -- Easy Plugin Installation
		_Pathogen_  	 -- Easy Plugin Infection
		_NERDtree_  	 -- Tree Navigation
		_CTags_	    	 -- Break out compiled symbols
		_scala-vim_ 	 -- Scala Syntax Support
		_supertab _ 	 -- Tab Support
		_YouCompleteMe_  -- Completion support
		_vimcolorschemes_-- All the color schemes
### System Helpful Commands (.bashrc contents)
		# Handle fusion's unwieldly directory structure
		function fusionDirectoryMadnessSolution() {
			declare -a arr=("higgs" "heisenberg" "tachyon-storage" "chronotrack-protocols" "tachyon")
			for i in "${arr[@]}"
			do  
				# generate tags, eclipse, and coverage in each directory
				genTags "$i"
			done
		}

		function eclim() {
			$HOME/eclipse/eclimd
		}

		function genTags() {
			# coverage       ==> Generates test coverage
			# coverageReport ==> Creates report of test coverage in target/scala-2.11/coverage-reports/index.html
			# gen-ctags      ==> Creates .tags file for vim to use as IDE
			# eclipse        ==> Generates .classpath and .project files for importing into vim
			cd "$HOME/Git/$1" && sbt compile coverage coverageReport gen-ctags eclipse
		}
	
		# Simply a smaller alias to fusionDirectoryMadnessSolution
		# stands for "[C]ompile [F]usion for [V]IM"
		function cfv() {
			fusionDirectoryMadnessSolution

		}

### Installation Guide
1. Download and extract Eclipse .tar.gz file to $HOME/eclipse
2. Download and Install Vim (`sudo apt-get install vim`)
3. Download and run Eclim (Wizard will ask for the new eclipse folder, and some basic JDK setup questions)
4. Install Vundle for vim with `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
5. Add to `$HOME/.vimrc`:


		set nocompatible              " be iMproved, required
		filetype off                  " required

		" set the runtime path to include Vundle and initialize
		set rtp+=~/.vim/bundle/Vundle.vim
		call vundle#begin()
		" alternatively, pass a path where Vundle should install plugins
		"call vundle#begin('~/some/path/here')

		" let Vundle manage Vundle, required
		Plugin 'VundleVim/Vundle.vim'


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

6. Install Pathogen with 
```
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```
7. Run this `echo "execute pathogen#infect()" >> $HOME/.vimrc` to add pathogen infection to `$HOME/.vimrc`
8. Install VIM Plugins by adding these lines to your `$HOME/.vimrc`
```
	Plugin 'derekwyatt/vim-scala'
	Plugin 'ervandew/supertab'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'flazz/vim-colorschemes'
```
9. Install NERDtree
```
	cd ~/.vim/bundle
	git clone https://github.com/scrooloose/nerdtree.git
```
10. Install all plugins. Inside of VIM run `:PluginInstall`
11. To generate eclipse project from source files, run `cfv` from above.
12. To import your new project into vim, run `:ProjectImportDiscover ~/Git`
