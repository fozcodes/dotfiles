export "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## ALIASES ##
alias la="ls -la"

## FUNCTIONS/SHORTCUTS ##
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
