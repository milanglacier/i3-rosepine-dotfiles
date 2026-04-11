{ pkgs, lib, username, ... }: {
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = ["networkmanager" "wheel"];
    };

    nix.settings = {
        trusted-users = [username];
        experimental-features = ["nix-command" "flakes"];
        substituters = [
            "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.auto-optimise-store = true;

    nixpkgs.config.allowUnfree = true;

    networking.firewall.enable = true;

    services.openssh = {
        enable = true;
        settings = {
            X11Forwarding = true;
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
        openFirewall = true;
    };

    hardware.enableAllFirmware = true;
    services.pulseaudio.enable = false;
    security.polkit.enable = true;
}
