{ lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        zathura
        xfce.thunar
        kitty
    ];
}
