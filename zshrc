############################################################
# PATH
############################################################
export PATH=$PATH:~/.scripts:~/.local/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

############################################################
# Shell options
############################################################
HISTFILE=~/.cache/zsh/history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt APPEND_HISTORY            # Write to the history file when the shell exits, so they aren't shared across shells.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt vi

# https://stackoverflow.com/questions/78444358/backspace-does-not-work-on-vim-mode-in-mac-os-terminal
bindkey -M viins "^?" backward-delete-char

export VISUAL=nvim
export EDITOR="$VISUAL"
export LESS="-FRX"
export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1
# avoid git completion using branches that have been deleted locally
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

# only actual aliases here - this blocks shell loading
source ~/.scripts/aliases.zsh
if [[ -f ~/.scripts/falconer-aliases.zsh ]]; then
  source ~/.scripts/falconer-aliases.zsh
fi

############################################################
# Env-specific setup
############################################################

# this can't be done lazily, or tooling that depends on brew-installed binaries
# will fail
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

env_init() {
  # Set QT theme if in GNOME
  [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

  # Stripe stuff
  if [[ "$HOST" == st-kyeb* ]]; then
    # Recommended by go/zsh
    if [[ -f ~/.stripe/shellinit/zshrc ]]; then
      source ~/.stripe/shellinit/zshrc
    fi
    # Personal
    export PATH=$PATH:$HOME/stripe/scripts:$HOME/stripe/gh-cli/bin
    source ~/stripe/scripts/stripe-aliases.zsh
  fi

  # WSL setup
  if [[ -d /mnt/wsl ]]; then
    echo 'setting up WSL display...'
    # https://stackoverflow.com/a/64233268
    export DISPLAY_NUMBER="0.0"
    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):$DISPLAY_NUMBER
    export LIBGL_ALWAYS_INDIRECT=1
  fi
}

zoxide_init() {
  if command -v zoxide > /dev/null 2>&1; then
    eval "$(zoxide init zsh)"
  fi
}

fzf_init() {
  # Set up fzf
  export FZF_DEFAULT_COMMAND='rg --files'

  # Trying out atuin instead of fzf for ctrl+r
  # source <(fzf --zsh)
}

atuin_init() {
  if [ -f "$HOME/.atuin/bin/env" ]; then
    . "$HOME/.atuin/bin/env"
    eval "$(atuin init zsh)"
  fi
}
atuin_init

nodenv_init() {
  command -v nodenv > /dev/null 2>&1 && eval "$(nodenv init -)"
}
nodenv_init

#################################
# Plugins
#################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# load compinit immediately so compdef works
autoload -Uz compinit && compinit

# Prompt first
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit load sindresorhus/pure
# Prompt config
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0

# Heavily used plugins; load them first
zinit ice wait'1' lucid id-as"zoxide-init" atload'zoxide_init'
zinit light zdharma-continuum/null

zinit ice wait'1' lucid as"completion"
zinit snippet https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# Important but not used constantly
zi wait'2' lucid for \
  zdharma-continuum/fast-syntax-highlighting
zinit ice wait'2' lucid id-as"fzf-init" atload'fzf_init'
zinit light zdharma-continuum/null

# Lazy-loaded bits that are useful but can wait a few seconds before loading
zinit ice wait'3' lucid id-as"env-init" atload'env_init'
zinit light zdharma-continuum/null

# graphite completion
zinit ice wait'2' lucid id-as"gt-completion" atload'command -v gt > /dev/null 2>&1 && eval "$(gt completion zsh)"'
zinit light zdharma-continuum/null

# git alias completions
compdef _git gsw=git-switch
compdef _git gswc=git-switch
compdef _git gco=git-checkout
compdef _git gb=git-branch
compdef _git gbd=git-branch
compdef _git gbD=git-branch
compdef _git grb=git-rebase
compdef _git grbi=git-rebase
compdef _git gcp=git-cherry-pick
compdef _git gd=git-diff
compdef _git gds=git-diff
compdef _git gl=git-log
compdef _git glp=git-log

# bun completions
[ -s "/Users/kyeb/.bun/_bun" ] && source "/Users/kyeb/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# opencode
export PATH=/Users/kyeb/.opencode/bin:$PATH

# Machine-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
