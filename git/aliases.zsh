##compdef git gco 

# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
# hub_path=$(which gh)
# if [[ -f $hub_path ]]
# then
#  alias git=$hub_path
# fi

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

# The rest of my fun git aliases
alias g='git'
alias gw='git worktree'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff -- ":!package-lock.json" ":!yarn.lock"'
alias gc='git commit -S'
alias gca='git commit -a'
alias gco='git checkout'
#alias gb='git branch'
alias gb='git branch | cut -c 3- | fzf --multi --preview="git log {} --"'
alias gbr='git branch -rl "origin/*" | cut -c 10- | fzf | xargs git checkout'
alias gbc='git branch | cut -c 3- | fzf --preview="git log {} --" | xargs git checkout'
#compdef _git gdv=git-branch
#compdef _git gco=git-branch

alias gst='git status'
alias ga='git add'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$2}' | xargs git rm"
alias gcm='git checkout $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias gprc='hub pull-request -b $(git_main_branch) -h $(git_current_branch) -f < .github/pull_request_template.md'
alias grv='git remote -v'
alias gr='git restore'
alias grs='git restore --staged'
alias gssp='git stash show -p'
# Fetch a pull request from github to a branch
# @param pull request id
# @param new branch name
# Eg : gpr 216 features
#      will fetch pull request 216 to the branch 216-features
gpr(){
  git fetch upstream pull/$1/head:$1-$2
}

# Git log for a particular date
# @param date
#       in format 2015-01-08
# @param option
#       any git log option mainly for --online
gld(){
  git log --after="$1 00:00" --before="$1 23:59" $2
}
