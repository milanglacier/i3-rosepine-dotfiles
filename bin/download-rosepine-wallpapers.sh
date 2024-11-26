#!/usr/bin/env bash

if [ -z "$MY_DOTFILES_DIR" ]; then
    MY_DOTFILES_DIR="$HOME/Desktop/dotfiles"
fi;

mkdir -p "$MY_DOTFILES_DIR/config/feh"

cd "$MY_DOTFILES_DIR/config/feh"

curl -o rose-pine-dawn-wallpaper.jpeg https://i.imgur.com/m1g96Q3.jpeg
curl -o rose-pine-moon-wallpaper.jpeg https://i.imgur.com/kuBdot9.jpeg
