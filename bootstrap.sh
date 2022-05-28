#!/usr/bin/env bash

#install brew and brews
#./install_brews.sh

#install asdf for package management
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0

# install ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

# install erlang
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

# install elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

# install node
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.github

# install terraform
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.github

# install Lua
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git


#install

# setup fonts
git clone git@github.com:powerline/fonts.git
./fonts/install.sh
rm -rf .fonts

# setup fish
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
curl -L https://get.oh-my.fish | fish
omf install agnoster
omf theme agnoster

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdirp ~/.vim/sessions

# copy rcm config
ln -s ~/.dotfiles/.rcrc ~/.rcrc
rcup

# setup ssh keys (You'll need to gen one...)
mkdir -p ~/.ssh
mv ./config/ssh/config ~/.ssh/config
ssh-keygen -t rsa -b 4096 -C "ian@codeguy.io"
ssh-add -K ~/.ssh/id_rsa
