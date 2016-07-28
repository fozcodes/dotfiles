export "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Import aliases
source $HOME/.aliases.local
### Import functions
source $HOME/.functions.local

### Enable git completions
source ~/.git-completion.bash

### Avoid homebrew rate limit
export HOMEBREW_GITHUB_API_TOKEN=4d2bdd5c82f41f6b76151e89cf5bfd8a33036e48

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
