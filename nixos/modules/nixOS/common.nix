{ pkgs, username, ... }:
{

  environment.systemPackages = with pkgs; [
    appimage-run
    # Codex relies on bubblewrap to provide a sandboxed environment for the
    # agent
    bubblewrap

    neovim
    wget
    curl
    git
    sysstat
    psmisc
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
    mosh

    zip
    unzip

    libnotify
    xdg-utils

    nodejs

    python3

    universal-ctags
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
