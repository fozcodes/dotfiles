export "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Import aliases
source $HOME/.aliases.local
### Import functions
source $HOME/.functions.local

### Enable git completions
source ~/.git-completion.bash

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
