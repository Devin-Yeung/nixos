{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.ycg.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      vimium
    ];
  };
}
