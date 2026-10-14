{ inputs, ... }:
let
  pkgsNightly = import inputs.nixpkgs-nightly {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  flake.nixosConfigurations.curry = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs pkgsNightly; };
    modules = [
      inputs.home-manager.nixosModules.home-manager
      ../hosts/curry
    ];
  };
}
