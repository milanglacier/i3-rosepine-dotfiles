{ pkgs, config, username, ... }: {
    programs = {
        firefox = {
            enable = true;
            policies = {
                ExtensionSettings = {
                    # We rely on manual installation to obtain each extension’s ID.
                    # Therefore, we have chosen not to block manual
                    # installations, even if considered "impure".
                    # "*".installation_mode = "blocked";

                    # To retrieve an extension’s ID, install it manually from
                    # the Firefox Add-ons Store, then locate the ID in
                    # about:support.
                    "addon@darkreader.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                        installation_mode = "normal_installed";
                        private_browsing = true;
                    };
                    # Surfing keys
                    "{a8332c60-5b6d-41ee-bfc8-e9bb331d34ad}" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/{a8332c60-5b6d-41ee-bfc8-e9bb331d34ad}/latest.xpi";
                        installation_mode = "normal_installed";
                        private_browsing = true;
                    };
                };
            };
        };
    };
}
