{ pkgs, ... }: {

    imports = [
        ../../modules/darwin/system.nix
        ../../modules/darwin/common.nix
        ../../modules/darwin/homebrew.nix
        ../../modules/darwin/tailscale.nix
    ];

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

}
