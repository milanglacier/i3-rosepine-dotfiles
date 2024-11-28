{ pkgs, config, my-dots-dir, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;

        initExtraFirst = ''
            [[ -f $HOME/.user-zshrc ]] && source $HOME/.user-zshrc
        '';

        history.size = 200000;

        # While I prefer using zimfw to manage my zsh config and plugins.
        # It is non-trivial to use zimfw on nixOS.
        # Use zplug instead since nix home-manager has builtin support.
        zplug = {
            enable = true;
            plugins = [
                { name = "zimfw/environment"; }
                { name = "zimfw/input"; }
                { name = "zimfw/utility"; }
                { name = "zimfw/termtitle"; }
                { name = "zsh-users/zsh-autosuggestions"; }
                { name = "zsh-users/zsh-syntax-highlighting"; }
                { name = "zsh-users/zsh-history-substring-search"; tags = [defer:2]; }
                { name = "zsh-users/zsh-completions"; tags = [defer:3]; }
                { name = "Aloxaf/fzf-tab"; tags = [depth:1]; }
                { name = "romkatv/powerlevel10k"; tags = [as:theme depth:1]; }
            ];

        };
    };

    # Make xdg-open and open the same between macOS and Linux
    home.shellAliases.${if pkgs.stdenv.isLinux then "open" else "xdg-open"} =
        "${if pkgs.stdenv.isLinux then "xdg-open" else "open"}";

    home.file.".user-zshrc".source = let
        dots-dir = my-dots-dir config;
        link = config.lib.file.mkOutOfStoreSymlink;
    in
        link "${dots-dir}/home/.zshrc";

    home.sessionPath = ["$HOME/.local/bin" "${my-dots-dir config}/bin"];

    home.file.".xprofile".text =  ''
        export QT_SCALE_FATOR=2
        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$PATH:${my-dots-dir config}/bin"
        # This is required for IM working in kitty
        export GLFW_IM_MODULE=ibus
    '';
}
