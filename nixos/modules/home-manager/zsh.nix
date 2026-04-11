{ pkgs, config, my-dots-dir, lib, ... }: {
    programs.zsh = {
        enable = true;
        # Keep the default configuration directory for Zsh. I prefer to avoid
        # migrating to the XDG directory structure until Zsh offers official
        # upstream support, rather than relying on Home Manager's workaround
        # (which became the default after version 26.05).
        dotDir = config.home.homeDirectory;
        enableCompletion = true;
        # don't call compinit as zimfw will call it for us.
        completionInit = "";

        initContent = let
            zshConfigBeforeInit = lib.mkOrder 500
                ''
                [ -f "$HOME/.zsh-preload.sh" ] && source ~/.zsh-preload.sh
                [ -f "$HOME/.zimfw-setup.sh" ] && source ~/.zimfw-setup.sh'';
            zshConfigAfterInit = lib.mkOrder 1200
                ''[ -f "$HOME/.zsh-postload.sh" ] && source ~/.zsh-postload.sh'';
        in
            lib.mkMerge [ zshConfigBeforeInit zshConfigAfterInit ];

        profileExtra = lib.mkOrder 500 ''
            [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
            [[ -f "${my-dots-dir config}/creds/api-keys.sh" ]] && source "${my-dots-dir config}/creds/api-keys.sh"
        '';

        history.size = 200000;
    };

    # Make xdg-open and open the same between macOS and Linux
    home.shellAliases.${if pkgs.stdenv.isLinux then "open" else "xdg-open"} =
        "${if pkgs.stdenv.isLinux then "xdg-open" else "open"}";

    home.sessionPath = ["$HOME/.local/bin" "${my-dots-dir config}/bin"];
}
