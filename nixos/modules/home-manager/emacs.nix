{ pkgs, lib, ... }: {
    # On Linux, install Emacs from Nix.
    # On macOS, use the prebuilt binary from jimeh/emacs-builds on GitHub.
    programs.emacs = lib.mkIf pkgs.stdenv.isLinux {
        enable = true;
        package = pkgs.emacs;
    };

    home.packages = with pkgs; [
        # Ensure that Universal Ctags takes precedence over Emacs' built-in
        # ctags. To achieve this, install Universal Ctags both at the system
        # level and within the home directory.
        universal-ctags
        # I use notmuch as my Mail User Agent (MUA) and msmtp for sending
        # email. For IMAP synchronization, I utilize a self-hosted container
        # running mbsync. I chose this setup primarily because Debian and
        # Ubuntu offer built-in OAuth2 support for mbsync, whereas installing
        # it on other platforms requires non-trivial plugin installation and
        # manual compilation.
        msmtp
        notmuch
        rassumfrassum
    ];

    # See nix-darwin issue #342 for how to pass the notmuch's elisp directory
    # to emacs load-path.
    home.sessionVariables = {
        NIX_NOTMUCH_EMACS_LOAD_PATH = "${pkgs.notmuch.emacs}/share/emacs/site-lisp";
    };

}
