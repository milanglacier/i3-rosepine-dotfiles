{ config, pkgs, ... }:

{
    imports = [
        ../../modules/system/system.nix
        ../../modules/system/fhs.nix
        ../../modules/system/common.nix
        ../../modules/system/gui.nix
        ../../modules/system/fcitx5.nix
        ../../modules/system/gui-apps.nix
        ../../modules/system/browsers.nix

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
