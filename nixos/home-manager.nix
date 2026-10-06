{ inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  # Home Manager is a separate `evalModules` run, so NixOS `_module.args`
  # (including the `specialArgs` above) never reach HM modules. Mirror
  # `inputs` into the HM module system explicitly.
  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.ycg = {
    imports = [
      ../modules/home-manager
      ../home
    ];
  };
}
