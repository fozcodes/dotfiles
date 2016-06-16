export "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Import aliases
source .aliases.local

## FUNCTIONS/SHORTCUTS ##
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
