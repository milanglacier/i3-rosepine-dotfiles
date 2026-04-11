{ config, lib, pkgs, ... }: {
    programs.password-store = {
        enable = true;
        settings = {
            PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
        };
    };
    # HACK:To ensure `pass` functions correctly when password-store is managed
    # by home-manager, GPG must also be managed by home-manager. Otherwise,
    # `pass` may attempt to execute the GPG binary located in the Nix store. If
    # the Nix version of GPG is not accessible through your PATH, and
    # consequently lacks your imported private key, decryption failures may
    # occur due to a GPG program mismatch.
    programs.gpg = {
        enable = true;
        mutableKeys = true;
    };
    services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        defaultCacheTtl = 7200;
        pinentry.package = if pkgs.stdenv.isLinux then pkgs.pinentry-tty else pkgs.pinentry_mac;
    };
}
