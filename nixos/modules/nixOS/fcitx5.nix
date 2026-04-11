{ config, pkgs, ... }: {
    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
            qt6Packages.fcitx5-configtool
            fcitx5-rime
            fcitx5-gtk
        ];
    };

    environment.sessionVariables = {
        # This is required for fcitx5 working under kitty
        GLFW_IM_MODULE = "ibus";
    };
}
