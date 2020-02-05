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
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_get_config_variables "alias"`; do
    alias g$al="git $al"
    complete_func=_git_$(__git_aliased_command $al)
    __git_complete g$al $complete_func
done

export hrs="--human-readable --recursive --summarize"
export h="--human-readable"
export r="--recursive"
export s="--summarize"
export hr="--human-readable --recursive"
export hs="--human-readable --summarize"
export rs="--recursive --summarize"

export LSCOLORS=cxfxcxdxbxcgcdabagacad

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

source ~/.inputrc

cd ~/dev
