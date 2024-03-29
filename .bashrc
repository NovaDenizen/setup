# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ls='ls -F'
alias ack='ack-grep'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

MAILDIR=$HOME/.maildir
export MAILDIR
export EDITOR=/usr/bin/vi

#alias cabal=$HOME/.cabal/bin/cabal
export LANG=en_US.utf8

function fvi {
    vi -c ":find $*"
}

function fless {
    less `find . -name "$*"`
}

alias ghc='ghc -Wall'
alias ghci='ghci -Wall'

# PROFILEPATH is the PATH provided by /etc/profile
#PATH=$HOME/.cabal/bin:$PROFILEPATH

_completefvi() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(git ls-tree -r --name-only HEAD | sed 's#.*/##')
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

lookfor() {
    git ls-tree -r --name-only -z HEAD | xargs -0 /bin/grep "$@" 
}

complete -F _completefvi fless
complete -F _completefvi fvi
export PAGER=/bin/less
