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

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_get_config_variables "alias"`; do
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

export REPOS_ROOT=/Users/steverobinson-burns/dev

export LEIN_USERNAME=steve.robinsonburns@previ.se
export LSCOLORS=cxfxcxdxbxcgcdabagacad

export PATH=$PATH:/Applications/Meld.app/Contents/MacOS:/Applications/Meld.app/Contents/MacOS:/Applications/Meld.app/Contents/MacOS
cd ~/dev