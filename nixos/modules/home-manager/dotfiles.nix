{ pkgs, config, my-dots-dir, wallpapers, ... }:
let
    # link configs located under home or located under xdg to my git repo
    dots-dir = my-dots-dir config;
    link = config.lib.file.mkOutOfStoreSymlink;
    link-home = src: { source = link "${dots-dir}/home/${src}"; };
    link-xdg = src: { source = link "${dots-dir}/config/${src}"; };
in
    {

    home.file = {
        # zsh related dotfiles
        ".zsh-preload.sh" = link-home ".zsh-preload.sh";
        ".zsh-postload.sh" = link-home ".zsh-postload.sh";
        ".zimfw-setup.sh" = link-home ".zimfw-setup.sh";
        ".zimrc" = link-home ".zimrc";
    };
    xdg.configFile = {
        "nvim" = link-xdg "nvim";
        "emacs" = link-xdg "emacs";
        "dunst" = link-xdg "dunst";
        "gtk-3.0" = link-xdg "gtk-3.0";
        "i3" = link-xdg "i3";
        "kitty" = link-xdg "kitty";
        "picom" = link-xdg "picom";
        "polybar" = link-xdg "polybar";
        "rofi" = link-xdg "rofi";
        "tmux" = link-xdg "tmux";
        "feh" = {
            source = "${wallpapers}";
            recursive = true;
        };
    };
}
