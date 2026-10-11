{
  inputs,
  pkgsNightly,
  ...
}:
{
  imports = [ "${inputs.home-manager-nightly}/modules/programs/devenv.nix" ];

  programs.devenv = {
    enable = true;
    package = pkgsNightly.devenv;
  };
}
