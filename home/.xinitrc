# setup fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
# The value of this environment variable can only be ibus to use fcitx with kitty
export GLFW_IM_MODULE=ibus
export XMODIFIERS=@im=fcitx

# the default font size of QT app is too small
export QT_SCALE_FACTOR=2

zsh -l -c 'exec i3'
