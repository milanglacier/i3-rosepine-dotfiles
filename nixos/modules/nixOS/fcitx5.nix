{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
            fcitx5-configtool
            fcitx5-chinese-addons
        ];
    };
}
