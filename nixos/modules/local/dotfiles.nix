{ pkgs, config, my-dots-dir, ... }:
let
    # link configs located under home or located under xdg to my git repo
    dots-dir = my-dots-dir config;
    link = config.lib.file.mkOutOfStoreSymlink;
    link-xdg = src: { source = link "${dots-dir}/config/${src}"; };
in 
    {
    xdg.configFile = {
        "dunst" = link-xdg "dunst";
        "feh" = link-xdg "feh";
        "gtk-3.0" = link-xdg "gtk-3.0";
        "i3" = link-xdg "i3";
        "kitty" = link-xdg "kitty";
        "picom" = link-xdg "picom";
        "polybar" = link-xdg "polybar";
        "rofi" = link-xdg "rofi";
        "tmux" = link-xdg "tmux";
    };
}
