{
    description = "Milan Glacier's nixOS configuration";

    # the nixConfig here only affects the flake itself, not the system configuration!
    nixConfig = {
        # additional binary cache servers
        extra-substituters = [
            # "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
            # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        nix-darwin.url = "github:nix-darwin/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        home-manager = {
            url = "github:nix-community/home-manager/master";

            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs dependencies.
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = inputs @ {
        self,
        nixpkgs,
        nix-darwin,
        home-manager,
        ...
        }: let
            # The directory to house my dotfiles, including the nixOS config.
            my-dots-dir = config : "${config.home.homeDirectory}/Desktop/dotfiles";
            systems = [ "aarch64-linux" "x86_64-linux" ];
            hosts = builtins.attrNames (builtins.readDir ./hosts);
            users = builtins.attrNames (builtins.readDir ./users);
            host-user-combinations = nixpkgs.lib.concatMap (
                host: builtins.map (
                    username: { inherit host username; }
                ) users
            ) hosts;

            # A helper function to set up system configurations based on the
            # device, host, or username.

            generate-system = system : host : username :
                let specialArgs = { inherit username my-dots-dir; };
                in
                    nixpkgs.lib.nixosSystem {
                        inherit specialArgs;
                        system = system;
                        modules = [
                            ./hosts/${host}
                            ./users/${username}

                            home-manager.nixosModules.home-manager {
                                home-manager = {
                                    useGlobalPkgs = true;
                                    useUserPackages = true;
                                    extraSpecialArgs = inputs // specialArgs;
                                    users.${username} = import ./users/${username}/home-manager.nix;

                                    # When home-manager overrides the config file,
                                    # create backup file for configuration file
                                    # already exists.
                                    backupFileExtension = "backup";
                                };
                            }
                        ];
                    };

            # To perform the initial installation of nix-darwin, execute:
            # sudo nix run 'nix-darwin/master#darwin-rebuild' -- switch --flake '.#Azure-Swing-northyear'
            # For subsequent system rebuilds after installation, use:
            # sudo darwin-rebuild switch --flake '.#Azure-Swing-northyear'
            generate-darwin = host : username:
                let specialArgs = { inherit username my-dots-dir; };
                in
                    nix-darwin.lib.darwinSystem {
                        inherit specialArgs;
                        modules = [
                            ./hosts/${host}
                            ./users/${username}

                            home-manager.darwinModules.home-manager {
                                home-manager = {
                                    useGlobalPkgs = true;
                                    useUserPackages = true;
                                    extraSpecialArgs = inputs // specialArgs;
                                    users.${username} = import ./users/${username}/home-manager.nix;

                                    # When home-manager overrides the config file,
                                    # create backup file for configuration file
                                    # already exists.
                                    backupFileExtension = "backup";
                                };
                            }
                        ];
                    };

            # Another helper function built on top of `generate-system`. For a
            # given user and host, it generates different NixOS system
            # configurations to either `aarch64` or `x86_64` architectures.
            generate-systems = host : username :
                builtins.listToAttrs (
                    builtins.map (
                        system: nixpkgs.lib.nameValuePair
                        "${host}-${username}-${system}"
                        (generate-system system host username)
                    ) systems
                );

            # For a standalone Home Manager installation:
            #
            # Standalone Home Manager profiles are generated automatically for
            # every directory under ./users, with both aarch64-linux and
            # x86_64-linux variants.
            #
            # To see the available profile names, run:
            # nix eval .#homeConfigurations --apply builtins.attrNames
            #
            # To perform the initial setup, use one of those names. For example:
            #
            # nix run 'home-manager/master#home-manager' -- switch -b backup --flake '.#x86_64-linux-milanglacier'
            #
            # To update the configuration after the initial setup, run:
            # home-manager switch -b backup --flake '.#x86_64-linux-milanglacier'
            #
            # NOTE: If you wish to set Zsh as your default shell, ensure
            # that the Nix Zsh path is added to the `/etc/shells` file. This
            # step is necessary because Home Manager only functions with the
            # Nix-provided Zsh.

            # NOTE: You need to manually add the following lines to
            # /etc/nix/nix.conf when using a standalone Home Manager:
            #
            # trusted-users = username
            # experimental-features = nix-command flakes
            generate-home-manager = system : username :
                let specialArgs = { inherit username my-dots-dir; };
                in {
                    "${system}-${username}" = home-manager.lib.homeManagerConfiguration {
                        pkgs = nixpkgs.legacyPackages.${system};
                        modules = [ ./users/${username}/home-manager.nix ];
                        extraSpecialArgs = inputs // specialArgs;
                    };
                };

        in {
            # NixOS profiles are generated automatically from every host/user
            # combination, with both aarch64-linux and x86_64-linux variants.
            # The names below are examples, not a fixed list:
            #
            # - adagioOfIslands-milanglacier-aarch64-linux
            # - adagioOfIslands-milanglacier-x86_64-linux
            #
            # To see the available profile names, run:
            # nix eval .#nixosConfigurations --apply builtins.attrNames
            #
            # To rebuild a NixOS system, use one of those names. For example:
            # sudo nixos-rebuild switch --flake '.#adagioOfIslands-milanglacier-x86_64-linux'
            nixosConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (
                builtins.map (
                    combo: generate-systems combo.host combo.username
                ) host-user-combinations
            );

            homeConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (
                nixpkgs.lib.concatMap (
                    username: builtins.map (
                        system: generate-home-manager system username
                    ) systems
                ) users
            );

            # Darwin profiles are generated automatically from every host/user
            # combination. Names such as Azure-Swing-northyear are examples,
            # not a fixed list.
            #
            # To see the available profile names, run:
            # nix eval .#darwinConfigurations --apply builtins.attrNames
            #
            # To rebuild a Darwin system, use one of those names. For example:
            # sudo darwin-rebuild switch --flake '.#Azure-Swing-northyear'
            darwinConfigurations = builtins.listToAttrs (
                builtins.map (
                    combo: nixpkgs.lib.nameValuePair
                    "${combo.host}-${combo.username}"
                    (generate-darwin combo.host combo.username)
                ) host-user-combinations
            );
        };
}
