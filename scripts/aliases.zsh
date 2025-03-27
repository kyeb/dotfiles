############################################################
# General
############################################################

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
alias gpl='git pull'
alias gco='git checkout'
alias gac='git add . && git commit -m'
alias gacp='git add . && git commit -m "update" && git push'

alias gb='git branch'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'

alias gcp='git cherry-pick'

alias gd='git diff'
alias gds='git diff --staged'

alias gl='git log'
alias glp='git log --patch'
