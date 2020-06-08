# Path to your oh-my-zsh installation.
[ -d "$HOME/.oh-my-zsh" ] && export ZSH="$HOME/.oh-my-zsh"

export PATH=$PATH:~/.scripts

PROMPT="%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{5}%~%F{red}]%f$ "

unsetopt beep
setopt appendhistory autocd

HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=100000

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)
# TODO: add zsh-syntax-highlighting install to .install.conf.yaml

# disable annoying default exit terminal on r
disable r

export VISUAL=vim
export EDITOR="$VISUAL"
export LESS="-FRX"

which R &>/dev/null && alias r="R -q --no-save"
which exa &>/dev/null && alias ls="exa"

alias ll="ls -la"
alias e="exit"
alias v="vim"
alias sv="sudo vim"


# Load nvm
[ -d "/usr/share/nvm" ] && source /usr/share/nvm/init-nvm.sh

# Set QT theme if in GNOME
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

# Load oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] && source $ZSH/oh-my-zsh.sh

# Stripe stuff
if [ "$HOST" = "st-kyeb1" ]; then
    autoload -Uz compinit; compinit
    autoload -Uz bashcompinit; bashcompinit
    source ~/.bash_profile
    source ~/.bashrc
    eval "$(nodenv init -)"
fi

