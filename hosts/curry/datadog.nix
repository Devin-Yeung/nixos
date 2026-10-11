{ ... }:
let
  # Key lives outside the repo and outside the Nix store.
  # Provision it manually: root:root, 0400.
  keyPath = "/var/lib/secrets/datadog-api-key";
in
{
  services.datadog-agent = {
    enable = true;
    site = "us5.datadoghq.com";
    apiKeyFile = "/run/credentials/datadog-agent.service/dd-api-key";
  };

  # systemd reads the source as root, then hands the service a private copy.
  systemd.services.datadog-agent.serviceConfig.LoadCredential = "dd-api-key:${keyPath}";

  systemd.tmpfiles.rules = [
    "d /var/lib/secrets 0700 root root -"
    "z ${keyPath} 0400 root root -"
  ];
}
