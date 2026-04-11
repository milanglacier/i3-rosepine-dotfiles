{ pkgs, config, username, ... }: {

    # This is required to use the homebrew module
    system.primaryUser = username;

    # We only use homebrew exclusively for installing casks, which are
    # primarily GUI applications.
    homebrew = {
        enable = true;
        # We use Nix exclusively to manage Homebrew. Consequently, any Homebrew
        # packages not installed via the Nix Homebrew module will be removed.
        onActivation.cleanup = "zap";
        taps = [
            "d12frosted/emacs-plus"
        ];
        casks = [
            "calibre"
            "davmail-app"
            "d12frosted/emacs-plus/emacs-plus-app"
            "hhkb"
            "iina"
            "karabiner-elements"
            "mos"
            "qmk-toolbox"
            "skim"
            "utm"
            "xquartz"
            "zen"
            "squirrel-app"
        ];
    };

}
