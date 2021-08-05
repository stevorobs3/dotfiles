#! /bin/bash

if [ -f .docker_aliases.sh ]; then
    source .docker_aliases.sh
fi

alias sbt='sbt -J-Xmx8G -J-Xms8G'
alias cdp='cd ~/projects'
alias cdd='cd ~/projects/dotfiles'
alias untargz='tar -zxvf'
alias pycl='find . -name "__pycache__" |  xargs -L1 rm -rf && find . -name "*.pyc" |  xargs -L1 rm -rf'
alias ffsp="git pull --rebase && lein test && git push"

source <(kubectl completion bash)

# make the command prompt look nice:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"



# change all git aliases from git X to gX plus attach the autocompletion
function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in $(git config --get-regexp '^alias\.' | cut -f 1 -d ' ' | cut -f 2 -d '.'); do
    alias g$al="git $al"
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func

done

export hrs="--human-readable --recursive --summarize"
export h="--human-readable"
export r="--recursive"
export s="--summarize"
export hr="--human-readable --recursive"
export hs="--human-readable --summarize"
export rs="--recursive --summarize"

export REPOS_ROOT=~/dev

export LEIN_USERNAME=steve.rb@previ.se
export LSCOLORS=cxfxcxdxbxcgcdabagacad

export PATH=$PATH:/Applications/Meld.app/Contents/MacOS:/Applications/Meld.app/Contents/MacOS:/Applications/Meld.app/Contents/MacOS:~/bin/

export LEIN_USE_BOOTCLASSPATH=no # fix lein ultra issue

function ssh-with-tunnel {
  host=$1
  tunnel=""

  for port in "${@:2}"
  do
    tunnel="$tunnel -L 1$port:localhost:$port"
  done

  if [ -z "$tunnel" ]
    then
      echo "Connecting to $host - without tunnelling"
      ssh $host
    else
      echo "Connecting to $host - tunnelling $tunnel"
      ssh $host $tunnel
    fi
}


alias k=kubectl


#terragrunt aliases
alias tp='terragrunt plan-all --terragrunt-source $REPOS_ROOT/infrastructure-modules -out=plan'
alias ta='terragrunt apply-all --terragrunt-source $REPOS_ROOT/infrastructure-modules plan'

terragrunt-taint-all () {
  resource_prefix=$1
  for resource in $(terragrunt state list --terragrunt-source $REPOS_ROOT/infrastructure-modules | grep "$resource_prefix.*"); do
    echo tainting $resource
    terragrunt taint $resource --terragrunt-source $REPOS_ROOT/infrastructure-modules;
  done
}


source ~/.inputrc

cd ~/dev
