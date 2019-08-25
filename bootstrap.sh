#!/usr/bin/env bash

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
#install cask
brew tap caskroom/cask

# install me brews -  the obscure ones are probably for asdf
brew install adns
brew install ansible
brew install autoconf
brew install automake
brew install aws-elasticbeanstalk
brew install awscli
brew install bash-completion
brew install battery
brew install circleci
brew install cmake
brew install cscope
brew install digdag
brew install direnv
brew install exercism
brew install fish
brew install freetype
brew install gdbm
brew install gettext
brew install gmp
brew install gnu-sed
brew install gnupg
brew install gnutls
brew install go
brew install grip
brew install heroku
brew install heroku-node
brew install htop
brew install hub
brew install icu4c
brew install imagemagick
brew install jemalloc
brew install jpeg
brew install jq
brew install leiningen
brew install libassuan
brew install libev
brew install libevent
brew install libffi
brew install libgcrypt
brew install libgpg-error
brew install libksba
brew install libnet
brew install libpng
brew install libssh
brew install libtasn1
brew install libtermkey
brew install libtiff
brew install libtool
brew install libunistring
brew install libusb
brew install libuv
brew install libvterm
brew install libxml2
brew install libxslt
brew install libyaml
brew install libzip
brew install lua
brew install msgpack
brew install nettle
brew install node
brew install npth
brew install oniguruma
brew install openssl
brew install openssl@1.1
brew install p11-kit
brew install parity
brew install pcre
brew install pcre2
brew install peco
brew install perform
brew install perl
brew install phantomjs
brew install pinentry
brew install pkg-config
brew install postgresql
brew install python
brew install qt@5.5
brew tap thoughtbot/formulae
brew install rcm
brew install readline
brew install reattach-to-user-namespace
brew install ripgrep
brew install ruby
brew install siege
brew install spark
brew install sqlite
brew install tcptraceroute
brew install telnet
brew install themekit
brew install tldr
brew install tmate
brew install tmux
brew install tree
brew install truncate
brew install unibilium
brew install universal-ctags
brew install unixodbc
brew install vim
brew install watchman
brew install wxmac
brew install xz
brew install yarn

# install casks
brew cask install 1password
brew cask install abstract
brew cask install adobe-reader
brew cask install airtable
brew cask install alacritty
brew cask install brave
brew cask install docker
brew cask install emacs
brew cask install firefox
brew cask install flux
brew cask install freedome
brew cask install front
brew cask install google-drive-file-stream
brew cask install google-chrome
brew cask install grammarly
brew cask install graphiql
brew cask install insomnia
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install java
brew cask install keycastr
brew cask install kindle
brew cask install licecap
brew cask install macdown
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
brew cask install visual-studio-code
brew cask install vlc
brew cask install whatsapp
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

# copy rcm config
ln -s ~/.dotfiles/.rcrc ~/.rcrc
rcup

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdirp ~/.vim/sessions

# setup ssh keys (You'll need to gen one...)
mkdir -p ~/.ssh
mv ./config/ssh/config ~/.ssh/config
