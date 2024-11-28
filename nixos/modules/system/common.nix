{ pkgs, username, ... }: {

    environment.systemPackages = with pkgs; [
        neovim
        wget
        curl
        git
        sysstat
        psmisc
        scrot
        fzf
        ripgrep
        vifm
        tmux
        xclip
        zoxide
        zsh
        dust
        delta
        htop

        zip
        unzip

        libnotify
        xdg-utils

        nodejs
        nodePackages.npm
    ];

    environment.shells = [pkgs.zsh];
}
