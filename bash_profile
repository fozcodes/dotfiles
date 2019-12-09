### Import aliases
source $HOME/.aliases.local
### Import functions
source $HOME/.functions.local

### Enable git completions
source ~/.git-completion.bash

### Avoid homebrew rate limit
export HOMEBREW_GITHUB_API_TOKEN=4d2bdd5c82f41f6b76151e89cf5bfd8a33036e48

### IEx history
export ERL_AFLAGS="-kernel shell_history enabled"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
