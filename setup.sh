# run this to install dev things

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# required!!!
brew install bash
# restart terminal
brew install git bash-completion@2

# git crypt

brew install gpg git-crypt


#k8s
brew install kubectl
brew tap johanhaleby/kubetail && brew install kubetail --with-short-names

# docker: https://hub.docker.com/editions/community/docker-ce-desktop-mac

# java 11
brew update
brew install openjdk@11
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk


# Python3 *for welcome repo)
brew install python3
brew install jq


# install sublime and then link
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

#others
brew install htop
brew install node
brew install awscli
brew install json-table
brew install pv
brew install jo
brew install wget

# clojure
brew install clojure/tools/clojure

# redis
brew install redis

# cloc

brew install cloc


# z standard 
brew install zstd

# dbeaver
brew install --cask dbeaver-community

# cmake - for flatbuffer project
brew install cmake