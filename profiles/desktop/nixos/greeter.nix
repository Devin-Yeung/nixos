{ pkgs, ... }:

let
  theme = pkgs.where-is-my-sddm-theme.override {
    themeConfig.General = {
      background = pkgs.nixos-artwork.wallpapers.binary-black.gnomeFilePath;
      # Version 1.12 reads backgroundMode, despite the name in theme.conf.
      backgroundMode = "aspect";
      passwordInputWidth = 0.1;
      passwordFontSize = 16;
      passwordCharacter = "•";
      passwordInputBackground = "#b3303030";
      passwordInputRadius = 6;
      passwordCursorColor = "#ffffff";
      font = "sans-serif";
      showUsersByDefault = false;
      showSessionsByDefault = false;
    };
  };
in
{
  environment.systemPackages = [
    theme
    pkgs.apple-cursor
  ];

  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    extraPackages = [ theme ];
    settings = {
      # Match the desktop's 150% scaling on the 4K display.
      General.GreeterEnvironment = "QT_SCALE_FACTOR=1.5";
      Theme = {
        CursorTheme = "macOS";
        CursorSize = 24;
      };
    };
  };
}
