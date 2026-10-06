{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./gpu.nix
    ../../nixos
  ];

  networking.hostName = "curry";

  # Do not change after installation without reviewing the NixOS release notes.
  system.stateVersion = "26.05";
}
