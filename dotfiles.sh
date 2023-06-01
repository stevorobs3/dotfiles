#! /bin/bash

if [ -f .docker_aliases.sh ]; then
    source .docker_aliases.sh
fi

alias sbt='sbt -J-Xmx8G -J-Xms8G'
alias untargz='tar -zxvf'
alias pycl='find . -name "__pycache__" |  xargs -L1 rm -rf && find . -name "*.pyc" |  xargs -L1 rm -rf'

source <(kubectl completion bash)

# make the command prompt look nice:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# source /usr/local/etc/bash_completion.d/git-completion.bash

#https://www.macinstruct.com/tutorials/how-to-enable-git-tab-autocomplete-on-your-mac/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


# change all git aliases from git X to gX plus attach the autocompletion
function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

# stuff to make git aliases work
_git_cherry-pick ()
{
  __git_find_repo_path
  if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
    __gitcomp "$__git_cherry_pick_inprogress_options"
    return
  fi

  __git_complete_strategy && return

  case "$cur" in
  --*)
    __gitcomp_builtin cherry-pick "" \
      "$__git_cherry_pick_inprogress_options"
    ;;
  *)
    __git_complete_refs
    ;;
  esac
}

_git_ls-files ()
{
  case "$cur" in
  --*)
    __gitcomp_builtin ls-files
    return
    ;;
  esac

  # XXX ignore options like --modified and always suggest all cached
  # files.
  __git_complete_index_file "--cached"
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

export LSCOLORS=cxfxcxdxbxcgcdabagacad

export PATH=~/bin/:$PATH


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


#terragrunt aliases
alias ti='terraform init'
alias tf='terraform fmt'
alias tp='terraform plan -out=plan.out'
alias ta='terraform apply plan.out'
alias tv='terraform validate'



# leiningen variables
export LEIN_SNAPSHOTS_IN_RELEASE=1
export LEIN_USE_BOOTCLASSPATH=no # fix lein ultra issue
export LEIN_USERNAME=steve@nyaya.tech

alias finder="open /System/Library/CoreServices/Finder.app"

source ~/.inputrc

cd ~/dev
