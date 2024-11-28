{ pkgs, ... }: {
    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;

    };
    users.users.milanglacier.shell = pkgs.zsh;
}
