# aliases

alias b="bundle"
alias be="bundle exec"
alias dkrmall="docker rm (docker ps -a -q)"
alias gaac="git add .; and git commit"
alias grb="git rebase -i origin/master"
alias grbc="git rebase --continue"
alias gitcleanbranches="git branch --merged | grep -v master | xargs git branch -D"
alias grep="grep --color --exclude=\"*/coverage/*\" --exclude=\"*.git/*\""
alias mkdir="mkdir -p"
alias npmi="npm install"
alias rcup="RCRC=\"~/.dotfiles/.rcrc\" rcup"
alias rst="touch tmp/restart.txt"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias tl="tmux ls"
alias psqlapp="'/Applications/Postgres.app/Contents/Versions/9.5/bin'/psql -p5432"

# functions

function mkdircd 
  mkdir -p $argv; and cd $argv
end

function npms
  npm install -SE $argv
end

function npmsd 
  npm install --save-dev $argv
end

function mixnew
  mix new $argv; and cd $argv
end

function phnew
  mix phoenix.new $argv; and cd $argv
end
