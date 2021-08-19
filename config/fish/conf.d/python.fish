####### PYTHON #######

#set python pretty print on everywhere
set -x TBVACCINE 1

# Function to get all the pyls stuff so language server halp
function pylspsetup
  pip install --upgrade pip
  pip install 'python-lsp-server[all]' pyls-flake8 pyls-mypy pyls-isort python-lsp-black
end

# search for a activate.fish file UP THE DIRECTORY TREE, starting from the current folder.
# if found, execute it.
# Intended for automatically switching to the python  virtual environment on entering the
# directories.  Can put in other initialization stuff.
function cd --description 'change directory - fish overload'

  builtin cd $param $argv

  emit fish_prompt

  if set -q VIRTUAL_ENV
    source "$VIRTUAL_ENV/bin/activate.fish"
    echo "Activated virtualenv: $VIRTUAL_ENV"
    return
  end

  set -l check_dir (pwd)
  # if myInit.fish is found in the home directory:
  if test -f "$check_dir/activate.fish"
    source $check_dir/myInit.fish
    echo "executed: source $check_dir/activate.fish"
    return
  end

  # Look up the directory tree for activate.fish:
  set check_dir (string split -r -m 1 / $check_dir)[1]

  while test $check_dir
    if test -f "$check_dir/activate.fish"
      source $check_dir/myInit.fish
      echo "executed: source $check_dir/activate.fish"
      break;
    else
      set check_dir (string split -r -m 1 / $check_dir)[1]
    end  # if ... else ...
  end  # while
end  # function

eval (direnv hook fish)

# pyenv
if type -q pyenv
  status --is-interactive; and source (pyenv init -|psub)
  status --is-interactive; and source (pyenv virtualenv-init -|psub)
  #set -x CPPFLAGS "-L(xcrun --show-sdk-path)/usr/include -L(brew --prefix bzip2)/include"
  #set -x LDFLAGS "-L(brew --prefix libressl)/lib -L(brew --prefix readline)/lib -L(brew --prefix zlib)/lib -L(brew --prefix bzip2)/lib"
  #set -x CFLAGS "-I(brew --prefix libressl)/include -I(brew --prefix bzip2)/include -I(brew --prefix readline)/include -I(xcrun --show-sdk-path)/usr/include"

  set -x LDFLAGS "$LDFLAGS -L/usr/local/opt/zlib/lib"
  set -x CPPFLAGS "$CPPFLAGS -I/usr/local/opt/zlib/include"
  set -x LDFLAGS "$LDFLAGS -L/usr/local/opt/sqlite/lib"
  set -x CPPFLAGS "$CPPFLAGS -I/usr/local/opt/sqlite/include"
  set -x PKG_CONFIG_PATH "$PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig"
  set -x PKG_CONFIG_PATH "$PKG_CONFIG_PATH /usr/local/opt/sqlite/lib/pkgconfig"
end
