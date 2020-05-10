
# Path to your oh-my-zsh installation.
[ -d "/home/$USER/.oh-my-zsh" ] && export ZSH="/home/$USER/.oh-my-zsh" && source $ZSH/oh-my-zsh.sh

export PATH=$PATH:~/.scripts

PROMPT="%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{5}%~%F{red}]%f$ "

unsetopt beep
setopt appendhistory autocd
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

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

disable r

export VISUAL=vim
export EDITOR="$VISUAL"

which exa &>/dev/null && alias ls="exa"

alias ll="ls -la"
alias r="R -q --no-save"
alias e="exit"
alias v="vim"
alias sv="sudo vim"

# Load nvm
[ -d "/usr/share/nvm" ] && source /usr/share/nvm/init-nvm.sh

# Set QT theme if in GNOME
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

