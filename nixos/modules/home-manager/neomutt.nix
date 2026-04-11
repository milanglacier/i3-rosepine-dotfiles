{ config, lib, pkgs, ... }: {
    home.packages = with pkgs; [
        neomutt
        notmuch
        # Required to open HTML email within neomutt
        w3m
    ];
}
