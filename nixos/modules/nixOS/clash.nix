{ pkgs, ... }: {
    programs.clash-verge = {
        enable = true;
        tunMode = true;
        serviceMode = true;
    };
}
