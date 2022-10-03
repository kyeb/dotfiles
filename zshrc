# Path to your oh-my-zsh installation.
[ -d "$HOME/.oh-my-zsh" ] && export ZSH="$HOME/.oh-my-zsh"

export PATH=$PATH:~/.scripts

command -v go > /dev/null 2>&1 && export GOPATH=$(go env GOPATH) && export PATH=$PATH:$GOPATH/bin

# Old prompt; leaving here for now
# PROMPT="%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{5}%~%F{red}]%f$ "

ZSH_THEME="typewritten/typewritten"
TYPEWRITTEN_DISABLE_RETURN_CODE=true
TYPEWRITTEN_RELATIVE_PATH="adaptive"

unsetopt beep
setopt appendhistory autocd

HISTFILE=~/.cache/zsh/history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# disable annoying default exit terminal on r
disable r

export VISUAL=nvim
export EDITOR="$VISUAL"
export LESS="-FRX"

which R &>/dev/null && alias r="R -q --no-save"
which exa &>/dev/null && alias ls="exa"

alias ll="ls -la"
alias e="exit"
alias v="vim"
alias n="nvim"
alias vim="nvim"
alias sv="sudo vim"
alias sn="sudo nvim"
alias f='nvim $(fzf)'
alias ssh="env TERM=xterm-256color ssh"

# TODO: Arch environment only
alias i="yay -S"

command -v nodenv > /dev/null 2>&1 && eval "$(nodenv init -)"

# Set QT theme if in GNOME
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

# Load oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] && source $ZSH/oh-my-zsh.sh || echo "oh-my-zsh not found"

# Stripe stuff
if [[ "$HOST" == st-kyeb* ]]; then
    autoload -Uz compinit; compinit
    autoload -Uz bashcompinit; bashcompinit
    source ~/.bash_profile
    source ~/.bashrc
    compdef _git stripe-git=git
    export PATH=$PATH:$HOME/stripe/scripts:$HOME/stripe/gh-cli/bin:$HOME/stripe/work/exe
    source ~/stripe/scripts/stripe-aliases.zsh
fi

set -o vi

# Set up fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='rg --files'
fi

