# Add directories to PATH
# Add npm to the directory path
# Add Google App Engine
export PATH="$PATH:/usr/games:/Users/nathan/bin:/usr/local/share/npm/bin:/Users/nathan/bin/go_appengine"


# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Include the z script for intelligent directory jumping
. $HOME/bin/z.sh

export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
