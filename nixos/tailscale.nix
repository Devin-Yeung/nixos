{ ... }:
{
  services.tailscale = {
    enable = true;
  };

  networking.firewall = {
    # allow all ports on tailscale0 interface
    trustedInterfaces = [ "tailscale0" ];
  };
}
