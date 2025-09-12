{ pkgs, ... }: {
    imports = [
        ../../modules/local/home.nix
        ../../modules/local/neovim.nix
        ../../modules/local/zsh.nix
        ../../modules/local/startx.nix
        ../../modules/local/xdg.nix
        ../../modules/local/dotfiles.nix
    ];

    programs.git = {
        enable = true;
        userName = "Milan Glacier";
        userEmail = "dev@milanglacier.com";
    };
}
