# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="/home/cheezy/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:/home/cheezy/Git/dev-tools/scripts:/home/cheezy/bin
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export GIT_HOME=/home/cheezy/Git

export GIT_TOP=/home/cheezy/Git
declare -a arr=("heisenberg"  "higgs"  "chronotrack-protocols" "tachyon-storage" "tachyon" "jxbrowser-provider" "lifepoint")

function toFile() {
    $1 | tee $2
}

function jrun() {
    cd $GIT_TOP/jajvam
    sbt run &
    cd ../jajvam-web
    npm install
    npm run dev
}

function fusionDirectoryMadnessSolution() {
	for i in "${arr[@]}"
	do
		genTags "$i"
	done
}

function doInEachDir() {
	for i in "${arr[@]}"
	do
		cd "$HOME/Git/$i"
		exec $1
	done
}

function bchrono() {
    $HOME/Git/dev-tools/scripts/chrono run &> ~/log.txt &
}


function eclim() {
    Xvfb :1 -screen 0 1024x768x24 &
    DISPLAY=:1 $HOME/eclipse/eclimd -b
}

function genTags() {
	cd "$HOME/Git/$1" && sbt clean compile gen-ctags eclipse publishLocal
}

function cfvFunc() {
	fusionDirectoryMadnessSolution
}

function stream() {
	livestreamer http://www.twitch.tv/$1 best
}

function jtags() {
    cd $HOME/Git/Projects/Jajvam/jajvam
    sbt eclipse gen-ctags
    cd ../jajvam-web
    ctags --language-force=js src/**/*.js
    cd ../ares/
    sbt eclipse gen-ctags
}

PATH="/home/cheezy/.conscript/bin:$PATH"

function g() {
    git $1
}

function pull() {
    g pull origin $1
}

function merge() {
    g pull -r origin $1
}

function push() {
    g push origin $1
}

function cdj() {
    cd "$HOME/Git/Projects/Jajvam/$1"
}

function jkafka() {
    docker-compose $(./listyml) up perseus-ctlive-kafka-event
}

function sledge() {
    docker rm -f $(docker ps -aq)
}

function vws() {
    vim -S "$HOME/sessions/US$1"
}

function a() {
    tmux -2 a -t "$1" || tmux -2 new -t "$1"
}
if [[ $TMUX ]]; then source ~/.tmux-git/tmux-git.sh; fi
