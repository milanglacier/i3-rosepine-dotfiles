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
    ];

    environment.shells = [pkgs.zsh];
}
