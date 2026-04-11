{ pkgs, config, lib, ... }: {
    options.milanglacier.langs = {
        bash = {
            enable = lib.mkEnableOption "Whether to install develop tools for bash development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [ shellcheck shfmt bash-language-server ];
                description = "List of packages to install for bash development";
            };
        };
        go = {
            enable = lib.mkEnableOption "Whether to install develop tools for go development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [ go gopls delve ] ;
                description = "List of packages to install for go development";
            };
        };
        sql = {
            enable = lib.mkEnableOption "Whether to install develop tools for sql development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [ sql-formatter ] ;
                description = "List of packages to install for sql development";
            };
        };
        markdown = {
            enable = lib.mkEnableOption "Whether to install develop tools for markdown development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [ prettierd ] ;
                description = "List of packages to install for markdown development";
            };
        };
        python = {
            enable = lib.mkEnableOption "Whether to install develop tools for python development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [
                    pyrefly
                    ruff
                    uv
                    (python3Packages.toPythonApplication python3Packages.jupytext)
                ];
                description = "List of packages to install for python development";
            };
        };
        rust = {
            enable = lib.mkEnableOption "Whether to install develop tools for rust development";
            packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = with pkgs; [ rustup ];
                description = "List of packages to install for rust development";
            };
        };
    };
    config = {
        home.packages = let
            langPackages = lib.attrValues config.milanglacier.langs;
            enabledLangPackages = lib.filter (lang: lang.enable) langPackages;
            packages = lib.concatLists (map (lang: lang.packages) enabledLangPackages);
        in
            packages;
    };
}
