{ pkgs, config, my-dots-dir, lib, ... }: {
    programs.zsh = {
        enable = true;
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

        # Only startx if there is no DISPLAY and we are on the first
        # virtual terminal
        profileExtra = lib.mkOrder 500 ''
            [[ -f "${my-dots-dir config}/creds/api-keys.sh" ]] && source "${my-dots-dir config}/creds/api-keys.sh"
        '';

        history.size = 200000;
    };

    # Make xdg-open and open the same between macOS and Linux
    home.shellAliases.${if pkgs.stdenv.isLinux then "open" else "xdg-open"} =
        "${if pkgs.stdenv.isLinux then "xdg-open" else "open"}";

    home.sessionPath = ["$HOME/.local/bin" "${my-dots-dir config}/bin"];
}
