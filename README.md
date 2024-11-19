# Installation

This rice runs on openSUSE but is compatible with other Linux
distributions. The only adjustment needed is modifying the package
names to match your system's package manager.

Follow these steps to set up your configuration:

```sh
### Install the dotfiles ###
mkdir -p ~/Desktop
cd ~/Desktop
git clone git@git.sr.ht:~northyear/i3-rosepine-dotfiles dotfiles
cd dotfiles

### Sync configuration files ###
mkdir -p ~/.config
mkdir -p ~/.local/bin
ln -s ~/Desktop/config/* ~/.config/
ln -s ~/Desktop/bin/* ~/.local/bin/
ln -s ~/Desktop/.zshrc ~/.zshrc
ln -s ~/Desktop/.zimrc ~/.zimrc
ln -s ~/Desktop/.zprofile ~/.zprofile
ln -s ~/Desktop/.xinitrc ~/.xinitrc

### Install packages ###
# Execute package installation only for openSUSE systems.
# For other distributions, manual package installation is required.
if command -v zypper; then
    INSTALL_X=1 ./bin/install-from-package-managers
fi

# Install fonts and theme components
./bin/download-release-packages
./bin/download-rosepine-gtk3-theme.sh
./bin/download-rosepine-wallpapers.sh
./bin/download-rosepine-fcitx5-theme.sh

# Set ZSH as default shell
chsh -s $(which zsh)
# Launch ZSH to configure powerlevel10k
zsh
```

# Showcase
