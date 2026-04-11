{ pkgs, ... }: {
    imports = [
        ../../modules/home-manager/home.nix
        ../../modules/home-manager/neovim.nix
        ../../modules/home-manager/helix.nix
        ../../modules/home-manager/emacs.nix
        ../../modules/home-manager/zsh.nix
        ../../modules/home-manager/dotfiles.nix
        ../../modules/home-manager/gh.nix
        ../../modules/home-manager/gnupg.nix
        ../../modules/home-manager/langs.nix
        ../../modules/home-manager/neomutt.nix
    ];


    milanglacier.langs = {
        go.enable = true;
        python.enable = true;
        rust.enable = true;
        bash.enable = true;
        sql.enable = true;
        markdown.enable = true;
    };

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "Milan Glacier";
                email = "dev@milanglacier.com";
            };
        };
        signing = {
            signByDefault = true;
            format ="openpgp";
            key = "FAD81662F34A7190F3173465EFEEBD96DA10C045";
        };
    };
}
