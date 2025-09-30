{
pkgs,
lib,
username,
...
}: {
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = ["networkmanager" "wheel"];
    };
    nix.settings.trusted-users = [username];

    nix.settings = {
        experimental-features = ["nix-command" "flakes"];
    };

    nix.gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    programs.dconf.enable = true;

    networking.firewall.enable = false;

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
    hardware.pulseaudio.enable = false;
    security.polkit.enable = true;

    services = {
        dbus.packages = [pkgs.gcr];

        geoclue2.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
