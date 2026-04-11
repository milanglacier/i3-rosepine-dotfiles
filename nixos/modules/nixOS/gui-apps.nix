{ lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        zathura
        thunar
        kitty
    ];
}
