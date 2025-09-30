{ config, pkgs, ... }:

{
    imports = [
        ../../modules/nixOS/system.nix
        ../../modules/nixOS/fhs.nix
        ../../modules/nixOS/common.nix
        ../../modules/nixOS/gui.nix
        ../../modules/nixOS/fcitx5.nix
        ../../modules/nixOS/gui-apps.nix
        ../../modules/nixOS/browsers.nix

        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
        };
        systemd-boot.enable = true;
    };

    networking.hostName = "qemu-nixos";
    networking.networkmanager.enable = true;

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "24.05";

    services.spice-vdagentd.enable = true;
}
