#!/usr/bin/env bash

mkdir -p ~/.lang-servers

# clone project
cd ~/.lang-servers
git clone  --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive

cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

