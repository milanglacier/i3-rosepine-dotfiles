{ pkgs, ... }: {
    users.users.northyear = {
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF5eqyOM/00YzBfRk+VvU6Sh4U0uClWJkGk8NVPzhh5S dev@milanglacier.com"
        ];
    };

    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };
    environment.shells = [ pkgs.zsh ];
    users.users.northyear.shell = pkgs.zsh;

}
