# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kyeb/.oh-my-zsh"

PROMPT="%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{5}%~%F{red}]%f$ "

unsetopt beep
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
setopt appendhistory autocd

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# nnn configuration
n() {
    export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd
    nnn -o "$@"
    if [ -f $NNN_TMPFILE ]; then
            . $NNN_TMPFILE
            rm $NNN_TMPFILE
    fi
}
# No idea if this works yet or not.
export NNN_COPIER="/home/kyeb/.config/nnn/copier"
export NNN_RESTRICT_NAV_OPEN=1

source $ZSH/oh-my-zsh.sh

export VISUAL=vim
export EDITOR="$VISUAL"
export PAGER=bat

if which exa &>/dev/null ; then
    alias ls="exa"
else
    echo "Using ls. (exa not found)"
fi

alias ll="ls -la"

eval $(dircolors -b $HOME/.dircolors)


