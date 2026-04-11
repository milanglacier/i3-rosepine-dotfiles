{ pkgs, username , ...}: {
    home = {
        inherit username;
        homeDirectory = if pkgs.stdenv.isLinux then "/home/${username}" else "/Users/${username}";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
}
