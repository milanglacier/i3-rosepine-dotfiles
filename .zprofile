export MY_DOTFILES_DIR="$HOME/Desktop/dotfiles"
[ -d "$MY_DOTFILES_DIR" ] && export PATH="$PATH:$MY_DOTFILES_DIR/bin"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
