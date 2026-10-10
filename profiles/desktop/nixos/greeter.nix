{ pkgs, ... }:

{
  # ReGreet (GTK greeter) replaces tuigreet. Its NixOS module enables
  # services.greetd and sets default_session to run regreet under cage on tty1.
  # Keep the login screen light and graphical, independently of app themes.
  programs.regreet = {
    enable = true;
    theme.name = "Adwaita";
    settings = {
      GTK.application_prefer_dark_theme = false;
      background = {
        path = pkgs.nixos-artwork.wallpapers.simple-blue.gnomeFilePath;
        fit = "Cover";
      };
      appearance.greeting_msg = "Welcome back!";
      widget.clock.format = "%a, %d %b  %H:%M";
    };
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };
  };
}
