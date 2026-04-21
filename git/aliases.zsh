# Helper functions
git_current_branch() { git symbolic-ref --short HEAD 2>/dev/null }
git_main_branch() {
  local branch
  for branch in main master trunk; do
    if git show-ref -q --verify refs/heads/$branch 2>/dev/null; then
      echo $branch
      return
    fi
  done
  echo main
}

# Basic
alias g='git'
alias gst='git status'
alias gss='git status -s'
alias gsb='git status -sb'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

# Branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbr='git branch --remote'

# Commit
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcam='git commit -a -m'
alias gcm='git commit -m'

# Checkout
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'

# Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Diff
alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

# Log
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glg='git log --stat'

# Pull
alias gl='git pull'
alias gpr='git pull --rebase'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'

# Push
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpoat='git push origin --all && git push origin --tags'

# Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbom='git rebase origin/$(git_main_branch)'

# Remote
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'

# Reset
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias groh='git reset origin/$(git_current_branch) --hard'

# Stash
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gstc='git stash clear'
alias gsts='git stash show --text'

# Misc
alias gm='git merge'
alias gma='git merge --abort'
alias gsh='git show'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gclean='git clean -id'
