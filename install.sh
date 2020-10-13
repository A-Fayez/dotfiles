#!/bin/bash 

set -uo pipefail
shopt -s dotglob
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'

echo "installing dotfiles.."

# shells
source "$HOME/dotfiles/shells/install"

# configs
mkdir -p "$HOME"/.config
for dir in "$HOME/dotfiles/config"/*; do
    ln -svf "$dir" "$HOME/.config"
done

# out-of-xdg confings
ln -svf "$HOME/dotfiles/.tmux.conf" "$HOME"
ln -svf "$HOME/dotfiles/.xinitrc" "$HOME"

tmux source-file ~/.tmux.conf
source ~/.zshrc

echo "Done!"

