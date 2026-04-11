# NOTE: Since tailscaled is configured to use a non-default socket location,
# you must manually specify the socket path when executing the `tailscale up`
# command.
# For example:
# tailscale --socket=/run/user/$(id -u)/tailscale/tailscaled.sock up --auth-key=xxxx
# Note: The `--socket` flag must be placed before the `up` subcommand, while
# the `--auth-key` flag must appear after it.
{ config, lib, pkgs, ... }:
let
    cfg = config.milanglacier.tailscale;
in {
    options.milanglacier.tailscale = {
        service.enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable the user-level tailscaled service in userspace mode";
        };
    };

    config = lib.mkMerge [
        { home.packages = [ pkgs.tailscale ]; }
        (lib.mkIf cfg.service.enable {
            systemd.user.services.tailscaled = {
                Unit = {
                    Description = "Tailscale daemon (userspace)";
                    After = [ "network-online.target" ];
                    Wants = [ "network-online.target" ];
                };
                Service = {
                    # User services don't have /var/run available; bind the
                    # socket under the user runtime dir and ensure the
                    # directory exists to avoid startup failure.
                    ExecStart = lib.concatStringsSep " " [
                        "${pkgs.tailscale}/bin/tailscaled"
                        "--tun=userspace-networking"
                        "--socks5-server=localhost:1055"
                        "--outbound-http-proxy-listen=localhost:1055"
                        "--socket=%t/tailscale/tailscaled.sock"
                    ];
                    RuntimeDirectory = "tailscale";
                    Restart = "on-failure";
                    RestartSec = "2s";
                };
                Install = {
                    WantedBy = [ "default.target" ];
                };
            };
        })
    ];
}
