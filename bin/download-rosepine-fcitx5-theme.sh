#!/bin/bash

mkdir -p ~/.local/share/fcitx5/themes

cd ~/.local/share/fcitx5/themes

git clone https://github.com/rose-pine/fcitx5.git

mv fcitx5/rose-pine-dawn rose-pine-dawn
mv fcitx5/rose-pine-moon rose-pine-moon

rm -rf fcitx5
