# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff -- ":!package-lock.json" ":!yarn.lock"'
alias gc='git commit -S'
alias gca='git commit -a'
alias gco='git checkout'
#alias gb='git branch'
alias gb='git branch | cut -c 3- | fzf --multi --preview="git log {} --"'
alias gbc='git branch | cut -c 3- | fzf --multi --preview="git log {} --" | xargs git checkout'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$2}' | xargs git rm"

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
