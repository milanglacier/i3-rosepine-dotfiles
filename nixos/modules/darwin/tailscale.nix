{ pkgs, ... }: {
    services.tailscale = {
        enable = true;
        # on macOS, nix does not provide config option to use userspace networking instead of systemwide VPN config.
        # You may want to manually call the tailscale command like this:
        # tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 &
        # before running: tailscale up --auth-key=<your-auth-key>
    };
}
