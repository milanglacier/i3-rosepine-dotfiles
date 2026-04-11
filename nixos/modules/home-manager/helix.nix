{ config, lib, pkgs, ... }: {
    home.packages = with pkgs; [
        jq
    ];

    programs = {
        helix = {
            enable = true;
        };
    };
}
