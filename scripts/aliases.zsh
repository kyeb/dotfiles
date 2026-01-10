############################################################
# General
############################################################

alias e="exit"
alias v="vim"
alias n="nvim"
alias clauded="claude --allow-dangerously-skip-permissions --permission-mode plan"

############################################################
# Git
############################################################

current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(current_branch)'
alias gst='git status'
alias gsw='git switch'
alias gswc='git switch -c'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias gpl='git pull --rebase --autostash'
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
alias grbm='git fetch origin main:main && git rebase main'

alias gcp='git cherry-pick'

alias gd='git diff'
alias gds='git diff --staged'

alias gl='git log'
alias glp='git log --patch'

alias gsta='git stash'
alias gstaa='git stash apply'
alias gstp='git stash pop'

alias gcm='git commit -m'

# Function to create a new branch and worktree with Graphite integration
wt() {
  if [ -z "$1" ]; then
    echo "Usage: wt <feature-name>"
    echo "Creates a worktree and initializes a Graphite branch named $USER/<feature-name> in it"
    return 1
  fi

  local feature_name="$1"
  local branch="$USER/$feature_name"
  local dirname="../$feature_name"
  
  # Check if directory already exists
  if [ -d "$dirname" ]; then
    echo "Error: Directory $dirname already exists"
    return 1
  fi
  
  # Create worktree from main branch
  echo "Creating worktree at $dirname from main branch..."
  git worktree add "$dirname" main
  
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create worktree"
    return 1
  fi
  
  # Change to the new worktree directory
  cd "$dirname"
  
  # Now create the Graphite branch while in the worktree
  echo "Creating Graphite branch $branch in the worktree..."
  gt create "$branch"
  
  if [ $? -eq 0 ]; then
    echo "✅ Created worktree at $dirname and initialized Graphite branch $branch"
  else
    echo "Error: Failed to create Graphite branch"
    cd -
    git worktree remove "$dirname"
    return 1
  fi
}

