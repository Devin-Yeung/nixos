{
  networking.networkmanager.enable = true;

  # mDNS/Bonjour so the host is reachable as `<hostName>.local`
  services.avahi = {
    enable = true;
    # Resolve other `.local` names from this machine too.
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
    };
  };
}
