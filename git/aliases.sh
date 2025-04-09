# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias glog="git log"
alias changelog="git log --pretty=format:'- %an: %s (%cr)' --abbrev-commit --date=relative --no-merges"
