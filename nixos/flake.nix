{
    description = "Milan Glacier's nixOS configuration";

    nixConfig = {
        # additional binary cache servers
        extra-substituters = [
            "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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
        home-manager,
        ...
        }: let
            # The directory to house my dotfiles, including the nixOS config.
            my-dots-dir = config : "${config.home.homeDirectory}/Desktop/dotfiles";
            # Factory function to generate system configurations based on
            # different systems, hosts, and usernames.
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
        in {
            nixosConfigurations = {
                qemu-aarch64 = generate-system "aarch64-linux" "qemu" "milanglacier";
                qemu-x86_64 = generate-system "x86_64-linux" "qemu" "milanglacier";
            };
        };
}
