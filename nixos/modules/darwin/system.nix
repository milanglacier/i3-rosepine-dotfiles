{ pkgs, username, ... }: {

    users.users."${username}" = {
        home = "/Users/${username}";
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

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
    };
    # Disable auto-optimise-store because of this issue:
    #   https://github.com/NixOS/nix/issues/7273
    # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
    nix.settings.auto-optimise-store = false;

    nixpkgs.config.allowUnfree = true;
}
