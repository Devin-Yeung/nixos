{ pkgs, ... }:
{
  # Install terminal fonts without changing desktop font defaults.
  home.packages = [
    pkgs.nerd-fonts.iosevka
    pkgs.lxgw-wenkai
  ];
}
