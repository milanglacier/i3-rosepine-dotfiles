{ pkgs, username, ... }: {

    environment.systemPackages = with pkgs; [
        bash
        gnused

        wget
        curl
        git
        fzf
        ripgrep
        fd
        vifm
        yazi
        lazygit
        tmux
        zoxide
        dust
        delta
        htop
        catimg
        mosh

        zip
        unzip

        nodejs

        python3

        universal-ctags

        # Nix-darwin lacks a builtin podman module
        podman
        podman-compose
    ];
}
