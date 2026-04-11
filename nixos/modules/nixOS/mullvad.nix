{ pkgs, ... }: {
    services.mullvad-vpn = {
        enable = true;
    };
    networking.nftables.enable = true;
    networking.nftables.tables.mullvadvpn = {
        family = "inet";
        content = ''
          chain excludeOutgoing {
            type route hook output priority 0; policy accept;
            # Whitelist local LAN traffic to allow access to local devices (e.g., NAS)
            ip daddr 192.168.0.0/24 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            # Whitelist Tailscale traffic
            ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            ip6 daddr fd7a:115c:a1e0::/48 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
        '';
    };
}
