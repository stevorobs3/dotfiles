# run this to install dev things

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git bash-completion


# docker: https://hub.docker.com/editions/community/docker-ce-desktop-mac

# java 11
brew update
brew tap homebrew/cask-versions
brew cask install java11

# Python3 *for welcome repo)
brew install python3
brew install jq

# install sublime and then link
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl