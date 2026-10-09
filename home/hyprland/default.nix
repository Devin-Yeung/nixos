{ pkgs, ... }:

{
  # Keep the cursor preference independent of app themes and fonts.
  home.pointerCursor = {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
  };

  # A packaged wallpaper gives translucent panels something to sit over.
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = pkgs.nixos-artwork.wallpapers.binary-black.gnomeFilePath;
          fit_mode = "cover";
        }
      ];
    };
  };

  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./launcher.nix
    ./notifications.nix
    ./tools.nix
  ];
}
