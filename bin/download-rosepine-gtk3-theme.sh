#!/usr/bin/env bash

mkdir -p ~/.themes
mkdir -p ~/.icons

# create a temporary directory
tmp_dir=$(mktemp -d)
echo $tmp_dir

ROSEPINE_VERSION=v2.1.0

cd $tmp_dir

curl -LO "https://github.com/rose-pine/gtk/releases/download/${ROSEPINE_VERSION}/gtk3.tar.gz"
# curl -LO "https://github.com/rose-pine/gtk/releases/download/${ROSEPINE_VERSION}/gtk4.tar.gz"
curl -LO "https://github.com/rose-pine/gtk/releases/download/${ROSEPINE_VERSION}/rose-pine-moon-icons.tar.gz"
curl -LO "https://github.com/rose-pine/gtk/releases/download/${ROSEPINE_VERSION}/rose-pine-dawn-icons.tar.gz"

mkdir -p gtk3
mkdir -p icons

# extrat gtk3.tar.gz to gtk3 folder
tar -xf gtk3.tar.gz -C gtk3
# extract the two icons to respective folder
tar -xf rose-pine-moon-icons.tar.gz -C icons
tar -xf rose-pine-dawn-icons.tar.gz -C icons

mv gtk3/gtk3/* ~/.themes/
mv icons/icons/* ~/.icons

rm -r $tmp_dir
