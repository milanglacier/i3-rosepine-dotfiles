{ config, pkgs, lib, ... }: {
    imports = [
        ../../modules/nixOS/system.nix
        ../../modules/nixOS/fhs.nix
        ../../modules/nixOS/common.nix
        ../../modules/nixOS/desktop/common.nix
        ../../modules/nixOS/desktop/i3.nix
        ../../modules/nixOS/fcitx5.nix
        ../../modules/nixOS/desktop/xrdp.nix
        ../../modules/nixOS/gui-apps.nix
        ../../modules/nixOS/browsers.nix
        ../../modules/nixOS/podman.nix
        ../../modules/nixOS/tailscale.nix

        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.useOSProber = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "Adagio";
    networking.networkmanager.enable = true;

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "25.05";

    services.spice-vdagentd.enable = true;
    services.qemuGuest.enable = true;
}
