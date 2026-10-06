{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../nixos
  ];

  networking.hostName = "nixos";

  # Do not change after installation without reviewing the NixOS release notes.
  system.stateVersion = "26.05";
}
