{ pkgs, ... }: {
    imports = [
        ../../modules/home-manager/options.nix
        ../../modules/home-manager/home.nix
        ../../modules/home-manager/neovim.nix
        ../../modules/home-manager/zsh.nix
        ../../modules/home-manager/startx.nix
        ../../modules/home-manager/xdg.nix
        ../../modules/home-manager/dotfiles.nix
    ];

    programs.git = {
        enable = true;
        userName = "Milan Glacier";
        userEmail = "dev@milanglacier.com";
    };
}
