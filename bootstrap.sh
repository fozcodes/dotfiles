#!/usr/bin/env bash

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
#install cask
brew tap caskroom/cask

# install me brews -  the obscure ones are probably for asdf
brew install ansible
brew install autoconf
brew install automake
brew install aws-elasticbeanstalk
brew install awscli
brew install bash-completion
brew install battery
brew install cmake
brew install coreutils
brew install direnv
brew install exercism
brew install fish
brew install freetype
brew install gdbm
brew install gettext
brew install git
brew install grip
brew install heroku
brew install hub
brew install imagemagick
brew install jpeg
brew install jq
brew install kubernetes-cli
brew install kubetail
brew install libtool
brew install libyaml
brew install libxml2
brew install libxslt
brew install openssl
brew install parity
brew tap thoughtbot/formulae
brew install rcm
brew install readline
brew install ripgrep
brew install siege
brew install sqlite
brew install terraform
brew install tmate
brew install tmux
brew install tree
brew install unixodbc
brew install vim

# install casks
brew cask install 1password
brew cask install adobe-reader
brew cask install brave
brew cask install docker
brew cask install emacs
brew cask install firefox
brew cask install flux
brew cask install freedome
brew cask install front
brew cask install google-chrome
brew cask install grammarly
brew cask install insomnia
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install java
brew cask install keycastr
brew cask install kindle
brew cask install libreoffice
brew cask install licecap
brew cask install macdown
brew cask install pencil
brew cask install postgres
brew cask install sequel-pro
brew cask install sketch
brew cask install slack
brew cask install spotify
brew cask install sqlpro-studio
brew cask install stretchly
brew cask install sublime
brew cask install sublime-text
brew cask install terraform
brew cask install vagrant
brew cask install virtualbox
brew cask install zeplin

# install ctags after emacs
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew link --overwrite universal-ctags

#install asdf for package management
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0

# install ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

# install erlang
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

# install elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

# setup fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

