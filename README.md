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
1. Install java 8:
```
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
```
2. Put `sbt-launch.jar` in `~/bin`
3. Add `~/bin` to `PATH` via `.bashrc` if not already there --> `echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bashrc`
4. Add this function to`~/.bashrc` and source it
```
function rsbt() {
	export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
	java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"
}

```
5. Install SBT/Scala:
```
	sudo apt-get remove scala-library scala
	wget http://www.scala-lang.org/files/archive/scala-2.11.6.deb
	sudo dpkg -i scala-2.11.6.deb
	sudo apt-get update
	sudo apt-get install scala

	echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
	sudo apt-get update
	sudo apt-get install sbt

	```
6. Download and extract Eclipse .tar.gz file to $HOME/eclipse
7. Download and Install Vim (`sudo apt-get install vim`) (For python support on Ubuntu 16.04+ do `sudo apt-get install gnome-vim`)
8. Download and run Eclim (Wizard will ask for the new eclipse folder, and some basic JDK setup questions)
9. Install Vundle for vim with `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
10. Add to `$HOME/.vimrc`:


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

11. Install Pathogen with 
```
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```
12. Run this `echo "execute pathogen#infect()" >> $HOME/.vimrc` to add pathogen infection to `$HOME/.vimrc`
13. Install VIM Plugins by adding these lines to your `$HOME/.vimrc`
```
	Plugin 'derekwyatt/vim-scala'
	Plugin 'ervandew/supertab'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'flazz/vim-colorschemes'
```
14. Install NERDtree
```
	cd ~/.vim/bundle
	git clone https://github.com/scrooloose/nerdtree.git
```
15. Install all plugins. Inside of VIM run `:PluginInstall`
16. To generate eclipse project from source files, run `cfv` from above.
17. To import your new project into vim, run `:ProjectImportDiscover ~/Git`

# For an up-to-date version of my current vim settings, please refer to `./.vimrc` in the repo 

