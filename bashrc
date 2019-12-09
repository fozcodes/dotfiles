export "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

### IEx history
export ERL_AFLAGS="-kernel shell_history enabled"
