{ pkgs, config, my-dots-dir, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        # don't call compinit as zimfw will call it for us.
        completionInit = "";

        initExtraFirst = ''
            [ -f "$HOME/.zsh-preload.sh" ] && source ~/.zsh-preload.sh
            [ -f "$HOME/.zimfw-setup.sh" ] && source ~/.zimfw-setup.sh
        '';
        initExtra = ''
            [ -f "$HOME/.zsh-postload.sh" ] && source ~/.zsh-postload.sh
        '';
        # Only startx if there is no DISPLAY and we are on the first
        # virtual terminal
        profileExtra = ''
            [[ -f "${my-dots-dir config}/creds/api-keys.sh" ]] && source "${my-dots-dir config}/creds/api-keys.sh"
            [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
        '';

        history.size = 200000;
    };

    # Make xdg-open and open the same between macOS and Linux
    home.shellAliases.${if pkgs.stdenv.isLinux then "open" else "xdg-open"} =
        "${if pkgs.stdenv.isLinux then "xdg-open" else "open"}";

    home.sessionPath = ["$HOME/.local/bin" "${my-dots-dir config}/bin"];

    home.file.".xinitrc".text = ''
        export QT_SCALE_FACTOR=2
        # This is required for IM working in kitty
        export GLFW_IM_MODULE=ibus
        export LIBGL_ALWAYS_SOFTWARE=1
        exec i3
    '';
}
