alias e="exit"
alias v="vim"
alias n="nvim"

############################################################
# Git
############################################################

current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

alias gp='git push'
alias gpsup='git push --set-upstream origin $(current_branch)'
alias gst='git status'
alias gsw='git switch'
alias gswc='git switch -c'
alias gcm='git commit -m'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gpl='git pull'
alias gco='git checkout'
alias gac='git add . && git commit -m'
alias gacp='git add . && git commit -m "update" && git push'

alias gd='git diff'
alias gds='git diff --staged'
